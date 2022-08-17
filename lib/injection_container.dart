import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/data_sources/posts_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/data_sources/posts_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture/features/posts/domain/repositories/repositories.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/add_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/delete_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/get_all_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/use_cases/update_post_usecase.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presntation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl=GetIt.instance;

Future <void>init()async{

  /// features  1.posts
    // bloc
  sl.registerFactory(() =>PostsBloc(getAllPosts: sl()) );
  sl.registerFactory(() =>AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost:  sl(),
      updatePost:  sl(),
  ));
    // useCases
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

    // repository
  sl.registerLazySingleton<PostsRepositories>(() => PostRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
    // dataSource
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()) );
  sl.registerLazySingleton<PostLocalDataSource>(() => PostsLocalDataSourceImpl(sharedPreferences: sl()));
  /// core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  /// External
  final sharedPreferences =await SharedPreferences.getInstance();
  sl.registerLazySingleton(() =>sharedPreferences );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
}