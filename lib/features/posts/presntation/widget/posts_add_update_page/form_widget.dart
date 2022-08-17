import 'package:clean_architecture/features/posts/domain/entities/posts.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final PostEntity? post;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  void validateFormThenUpdateOrAddPost(){
    final isValid=_formKey.currentState!.validate();
    if(isValid){
      final post=PostEntity(id:widget.isUpdatePost?widget.post!.id:null,
          title: _titleController.text,
          body: _bodyController.text);
      if(widget.isUpdatePost){
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(UpdatePostEvent(postEntity: post));
      }else{
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(AddPostEvent(postEntity: post));
      }

    }
  }

  @override
  void initState() {
    _titleController.text = widget.post!.title.toString();
    _bodyController.text = widget.post!.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Title must not be empty';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: _bodyController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Body must not be empty';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: 'Body',
              ),
              maxLines: 22,
              minLines: 6,
            ),
          ),
          ElevatedButton.icon(
              onPressed: validateFormThenUpdateOrAddPost,
              icon: widget.isUpdatePost ? Icon(Icons.update) : Icon(Icons.add),
              label: Text(widget.isUpdatePost ? "Update" : "Add"))
        ],
      ),
    );
  }
}
