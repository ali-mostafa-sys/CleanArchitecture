import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase{

  final PostsRepositories repositories;

  UpdatePostUseCase(this.repositories);

  Future<Either<Failure,Unit>> call(PostEntity post)async{
    return await repositories.updatePost(post);
  }
}