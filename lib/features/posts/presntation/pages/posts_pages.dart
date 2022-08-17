import 'package:clean_architecture/core/widget/loading_widget.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/pages/post_add_update_page.dart';
import 'package:clean_architecture/features/posts/presntation/widget/posts_page/message_display_widget.dart';
import 'package:clean_architecture/features/posts/presntation/widget/posts_page/posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),

    );
  }

  AppBar _buildAppBar()=>AppBar(title:const Text('Posts'),);
  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder(
        builder: (context,state){
          if(state is LoadingPostsState){
            return const LoadingWidget();
          }else if(state is LoadedPostsState){
            return RefreshIndicator(
              onRefresh:()=> _onRefresh(context),
                child: PostsListWidget(posts:state.postEntity));
          }else if(state is ErrorPostsState){
            return MessageDisplayWidget(message:state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
 Future<void> _onRefresh(BuildContext context)async{
    PostsBloc.get(context).add(RefreshPostsEvent());
  }
Widget  _buildFloatingBtn(BuildContext context){
    return FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const PostAddUpdatePage(isUpdatePost: false)));
    },child: const Icon(Icons.add),);
  }
}
