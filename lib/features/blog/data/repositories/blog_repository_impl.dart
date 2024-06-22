// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDataSource remoteDataSource;
  BlogRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, BlogModel>> uploadBlog(
      {required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl =
          await remoteDataSource.uploadBlogImage(image: image, blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final blog = await remoteDataSource.uploadBlog(blogModel);
      return (Right(blog));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
