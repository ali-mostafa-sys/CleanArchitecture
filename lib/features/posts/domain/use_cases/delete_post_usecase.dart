import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase{
   final PostsRepositories repositories;

  DeletePostUseCase(this.repositories);

  Future<Either<Failure,Unit>> call(int postId)async{
    return await repositories.deletePost(postId);
  }
}