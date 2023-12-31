import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/login/login_viewmodel.dart';

// final instance = GetIt.instance;
//
// Future<void> initAppModule() async {
//   final sharedPrefs = await SharedPreferences.getInstance();
//
//   instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
//
//   instance
//       .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
//
//   instance.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoIml(DataConnectionChecker()));
//
//   instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
//
//   final dio = await instance<DioFactory>().getDio();
//
//   instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
//
//   instance.registerLazySingleton<RemoteDataSource>(
//       () => RemoteDataSourceImplementor(instance()));
//
//   instance.registerLazySingleton<Repository>(
//       () => RepositoryImpl(instance(),instance()));
//
// }
//
// initLoginModule(){
//   if (!GetIt.I.isRegistered<LoginUseCase>()){
//
//     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
//     instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
//   }
//
// }
//

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance(),));
}

initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}