import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;



abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);

}
const BASE_URL='jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async{
   final uri =Uri.https(BASE_URL, '/posts/');
   final response= await client.get(uri,);
   if(response.statusCode==200){
     final List decodedJson= jsonDecode(response.body)as List;
     final List<PostModel> postModel=decodedJson.map((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
     return postModel;
   }else{
     throw ServerException();
   }
  }


  @override
  Future<Unit> addPost(PostModel postModel)async {
   final body={
     'title':postModel.title,
     'body':postModel.body,
   };
   final uri=Uri.https(BASE_URL, '/posts/',  );
   final response=await client.post(uri,body: body);
   if(response.statusCode==201){
     return Future.value(unit);
   }else{
     throw ServerException();
   }
  }

  @override
  Future<Unit> deletePost(int postId)async {
   final uri=Uri.https(BASE_URL, '/post/${postId.toString()}');
   final response=await client.delete(uri);
   if(response.statusCode==200){
     return Future.value(unit);
   }else{throw ServerException();}
  }



  @override
  Future<Unit> updatePost(PostModel postModel)async {
   final postId=postModel.id.toString();
   final body={
     'title':postModel.title,
     'body':postModel.body,
   };
   final uri=Uri.https(BASE_URL, '/posts/$postId');
   final response= await client.patch(uri,body: body);
   if(response.statusCode==200){
     return Future.value(unit);
   }else{
     throw ServerException();
   }
  }
  
}