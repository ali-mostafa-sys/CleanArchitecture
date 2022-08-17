import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/presntation/pages/post_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  List<PostEntity> posts;

  PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[index].body.toString(),
              style: TextStyle(fontSize: 16),

            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[index])  ));
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
              thickness: 1,
            ),
        itemCount: posts.length);
  }
}
