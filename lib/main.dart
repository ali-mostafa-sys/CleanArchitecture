import 'package:clean_architecture/core/app_theme.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/pages/posts_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main()async {

WidgetsFlutterBinding.ensureInitialized();
await di.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_)=>di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:appTheme,
        home:PostsPage(),
      ),
    );
  }
}


