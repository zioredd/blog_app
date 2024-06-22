import 'dart:io';

import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(
      {required String posterId,
      required String title,
      required String content,
      required List<String> topics,
      required File image});

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
