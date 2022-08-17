import 'package:clean_architecture/features/posts/domain/entities/posts.dart';

class PostModel extends PostEntity{

 const  PostModel({
     int? id,
    required String title,
    required String body,
}):super(id: id,title: title,body: body);

  factory PostModel.fromJson(Map<String,dynamic>json){
    final id=json['id'];
    final title=json['title'];
    final body=json['body'];
    return PostModel(id: id, title: title, body: body );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'body':body,

    };
  }

}