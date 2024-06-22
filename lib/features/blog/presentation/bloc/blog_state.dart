part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {}

class BlogError extends BlogState {
  final String message;

  const BlogError({required this.message});

  @override
  List<Object> get props => [message];
}
