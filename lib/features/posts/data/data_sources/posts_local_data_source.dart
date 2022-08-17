import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit>cachedPosts(List<PostModel> postModel);

}


class PostsLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<Unit> cachedPosts(List<PostModel> postModel) {
    List postsModeToJson=postModel.map<Map<String,dynamic>>((postModel) =>postModel.toJson() ).toList();
    sharedPreferences.setString('CACHED_POSTS', json.encode(postsModeToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString= sharedPreferences.getString('CACHED_POSTS');
    if(jsonString !=null){
      List decodeJsonData= json.decode(jsonString);
      List<PostModel> jsonToPostsModel= decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostsModel);
    }else{
      throw EmptyCacheException();
    }

  }
  
}