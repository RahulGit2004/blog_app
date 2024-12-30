import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/custom_exception.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  // final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String userId,
      required List<String> topics}) async {
    try {

      if(!await(connectionChecker.isConnected)) {
        return left(Failure("No Internet connection Present"));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imgUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blogModel: blogModel,
      );
      blogModel =  blogModel.copyWith(
        imgUrl: imageUrl,
      );

    final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
    return right(uploadedBlog);

    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {

      // if(!await(connectionChecker.isConnected)) {
      //   final blogs = blogLocalDataSource.loadBlogs();
      //   return right(blogs);
      // }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      // blogLocalDataSource.uploadLocalBlog(blogs: blogs);
      return right(blogs);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }

  }

}
