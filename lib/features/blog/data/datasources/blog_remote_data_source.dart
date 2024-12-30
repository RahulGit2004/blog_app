import 'dart:io';

import 'package:blog_app/core/error/custom_exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blogModel}) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blogModel.id, image);

      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } on StorageException catch (e) {
      throw CustomException(e.message);
    }
    catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      ///this will working
      ///like it goes to supabase blogs table and select all things with the help of * and after that it goes to profiles table
      ///with the help of userId , which present in my table blogs and give the name of that data.
      /// this is simply join operation
      final blogs =
          await supabaseClient.from('blogs').select('*,profiles(name)');

      return blogs
          .map((blog) => BlogModel.fromJson(blog).copyWith(
                userName: blog['profiles']['name'],
              ))
          .toList();
    } on PostgrestException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
