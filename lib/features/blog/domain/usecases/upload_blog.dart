// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  BlogRepository repository;
  UploadBlog(this.repository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await repository.uploadBlog(
        posterId: params.posterId,
        title: params.title,
        content: params.content,
        image: params.image,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
