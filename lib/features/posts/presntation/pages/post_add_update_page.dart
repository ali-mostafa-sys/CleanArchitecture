import 'package:clean_architecture/core/utils/snackbar_message.dart';
import 'package:clean_architecture/core/widget/loading_widget.dart';
import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/pages/posts_pages.dart';
import 'package:clean_architecture/features/posts/presntation/widget/posts_add_update_page/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post,required this.isUpdatePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppbar() ,
      body: _buildBody(),

    );
  }
  AppBar _buildAppbar()=>AppBar(
    title: Text(isUpdatePost?'Edit Post':'Add Post'),
  );
  Widget _buildBody(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc,AddDeleteUpdatePostState>(
          listener: (context,state){
            if(state is MessageAddDeleteUpdatePostState){
              SnackBarMessage().showSuccessSnackBar(message: state.message.toString(), context: context);

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>const PostsPage()),
                      (route) => false);
            }
            else if(state is ErrorAddDeleteUpdatePostState){
              SnackBarMessage().showErrorSnackBar(message: state.message.toString(), context: context);

            }
          },
          builder: (context,state){
            if(state is LoadingAddDeleteUpdatePostState){
              return const LoadingWidget();
            }

            return FormWidget(isUpdatePost:isUpdatePost,post:isUpdatePost?post:null);
          },
        ),
      ),
    );
  }
}
