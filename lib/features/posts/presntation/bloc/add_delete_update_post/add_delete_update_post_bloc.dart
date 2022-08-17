import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/string/failure.dart';
import 'package:clean_architecture/core/string/messages.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/add_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/delete_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/update_post_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
}) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit)async{
      if(event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.postEntity);
        emit(_etherDoneMessageOrErrorState(failureOrDoneMessage, ADDED_SUCCESS_MESSAGE));


      }else if(event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.postEntity);
        emit(_etherDoneMessageOrErrorState(failureOrDoneMessage, UPDATED_SUCCESS_MESSAGE));

      }else if(event is DeletePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_etherDoneMessageOrErrorState(failureOrDoneMessage, DELETED_SUCCESS_MESSAGE));

      }

    });
  }

  AddDeleteUpdatePostState _etherDoneMessageOrErrorState(Either<Failure, Unit> ether,String message){
    return ether.fold(
            (failure)  {
            return  ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure));

            },
            (_)  {
           return   MessageAddDeleteUpdatePostState(message: message);


            });
  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return " Unexpected error,Please try again later.";
    }
  }
}
