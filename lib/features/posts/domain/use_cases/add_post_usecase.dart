import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase{
  final PostsRepositories repositories;

  AddPostUseCase(this.repositories);


  Future<Either<Failure,Unit>> call(PostEntity post)async{
    return await repositories.addPost(post);
  }

}