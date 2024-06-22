// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlockUpload);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
  }

  void _onGetAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    print('BlogBloc: BlockFetch event is emitted!');
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) {
        print(
            'BlogGetAllBlogs: BlogError state emitted with message: ${l.message}');
        emit(BlogError(message: l.message));
      },
      (r) {
        print('BlogGetAllBlogs: BlogSuccess state emitted with message: $r');
        emit(BlogDisplaySuccess(r));
      },
    );
  }

  void _onBlockUpload(BlogUpload event, Emitter<BlogState> emit) async {
    print('BlogBloc: BlockUpload event is emitted!');
    final res = await _uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));

    res.fold(
      (l) {
        print('BlogBloc: BlogError state emitted with message: ${l.message}');
        emit(BlogError(message: l.message));
      },
      (r) {
        print('BlogBloc: BlogLoaded state emitted with message: $r');
        emit(BlogUploadSuccess());
      },
      // (r) => emit(BlogLoaded()),
    );
  }
}
