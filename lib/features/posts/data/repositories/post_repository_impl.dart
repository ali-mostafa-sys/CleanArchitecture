

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost ();
/// Future<Unit> Function()

class PostRepositoryImpl implements PostsRepositories{
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts()async {

   if(await networkInfo.isConnected){
     try{
       final remotePosts = await remoteDataSource.getAllPosts();
       localDataSource.cachedPosts(remotePosts);
       return Right(remotePosts);
     }on ServerException{
       return left(ServerFailure());
     }
   }else {
     try{
       final localPosts=await localDataSource.getCachedPosts();
       return Right(localPosts);
     }on EmptyCacheException{
       return left(EmptyCacheFailure());
     }
   }


  }


  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async{
   final PostModel postModel=PostModel( title: post.title, body: post.body);

   return await _getMessage(()async {
     return await remoteDataSource.addPost(postModel);
   });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return await _getMessage(()async {
      return await remoteDataSource.deletePost(postId);
    });
  }



  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post)async {
    final PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(()async {
      return await remoteDataSource.updatePost(postModel);
    });

  }

  Future<Either<Failure,Unit>>  _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost)async{
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAddPost;
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());

    }

  }

}