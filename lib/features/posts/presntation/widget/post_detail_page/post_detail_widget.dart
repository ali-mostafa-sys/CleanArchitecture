import 'package:clean_architecture/core/utils/snackbar_message.dart';
import 'package:clean_architecture/core/widget/loading_widget.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/pages/post_add_update_page.dart';
import 'package:clean_architecture/features/posts/presntation/pages/posts_pages.dart';
import 'package:clean_architecture/features/posts/presntation/widget/post_detail_page/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final PostEntity post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),
          Text(post.body,
          style: TextStyle(
            fontSize: 16,

          ),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>PostAddUpdatePage(isUpdatePost: true,post: post,)));
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed:()=> deleteDialog(context),
                icon: Icon(Icons.delete_outline),
                label: Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
 void deleteDialog(BuildContext context){
  showDialog(context: context, builder: (context){
   return   BlocConsumer<AddDeleteUpdatePostBloc,AddDeleteUpdatePostState>(
        listener: (context,state){
          if(state is MessageAddDeleteUpdatePostState){
            SnackBarMessage().showSuccessSnackBar(message:state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_)=>const PostsPage()),
                    (route) => false);
          }
          else if(state is ErrorAddDeleteUpdatePostState){
            Navigator.of(context).pop();
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
        },
          builder: (context,state){
         if(state is LoadingAddDeleteUpdatePostState){
           return AlertDialog(
             title: LoadingWidget(),
           );
         }
         return DeleteDialogWidget(postId:post.id!);
          },
          );
  });
  }
}
