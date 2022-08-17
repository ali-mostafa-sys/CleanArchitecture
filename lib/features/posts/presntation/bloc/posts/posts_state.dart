part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}
class LoadingPostsState extends PostsState{}
class LoadedPostsState extends PostsState{
  final List<PostEntity> postEntity;

  const LoadedPostsState({required this.postEntity});
  @override
  List<Object> get props => [postEntity];
}
class ErrorPostsState extends PostsState{
  final String message;

const  ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}
