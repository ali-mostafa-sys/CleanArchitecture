import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/string/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/get_all_post_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  static PostsBloc get(context)=> BlocProvider.of(context);



  final GetAllPostsUseCase getAllPosts;


  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit)async {
      if(event is GetAllPostsEvent|| event is RefreshPostsEvent){
        emit(LoadingPostsState());
        final failureOrPosts= await getAllPosts();
        emit(_mapFailureOrPostsState(failureOrPosts));


      }



    });
  }
  PostsState _mapFailureOrPostsState (Either<Failure, List<PostEntity>> either){
    return either.fold(
            (failure) =>ErrorPostsState(message: _mapFailureToMessage(failure)),
            (posts) =>LoadedPostsState(postEntity: posts)
    );
  }
  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACH_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return " Unexpected error,Please try again later.";
    }
  }

}
