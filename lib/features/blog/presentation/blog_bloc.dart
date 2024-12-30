import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlog>(_getAllBlogsMethod);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(
      UploadBlogPrams(
          userId: event.userId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics),
    );
    result.fold(
        (l) => emit(BlogFailure(l.message)), (r) => emit(BlogUploadSuccess()));
  }

  void _getAllBlogsMethod(BlogGetAllBlog event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoPrams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogDisplaySuccess(r),
      ),
    );
  }
}
