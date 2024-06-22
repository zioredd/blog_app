part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  const BlogUpload(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});

  @override
  List<Object> get props => [posterId, title, content, image, topics];
}
