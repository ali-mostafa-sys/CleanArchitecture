import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepositories {


  Future<Either<Failure,List<PostEntity>>> getAllPosts();
  Future <Either<Failure,Unit>> deletePost(int id);
  Future <Either<Failure,Unit>> addPost(PostEntity post);
  Future <Either<Failure,Unit>> updatePost(PostEntity post);
}