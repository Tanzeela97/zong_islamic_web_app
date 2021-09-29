import 'package:get_it/get_it.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/provider/api_client.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init()async{
  sl.registerLazySingleton(() =>MainMenuCategoryCubit(sl()));
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(() => ZongIslamicRemoteDataSourceImpl(sl()));
}