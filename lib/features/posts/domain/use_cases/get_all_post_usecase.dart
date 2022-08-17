import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase{
  final PostsRepositories repositories;

  GetAllPostsUseCase(this.repositories);
  Future<Either<Failure,List<PostEntity>>> call()async{
    return await repositories.getAllPosts();
  }
}