import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maslaha/core/MVVM/model/local/token_verification_local_data_source.dart';
import 'package:maslaha/core/MVVM/repository/i_token_verification_repository.dart';
import 'package:maslaha/core/MVVM/repository/token_verification_repository_impl.dart';
import 'package:maslaha/core/MVVM/view_model/ui_view_model/ui_cubit.dart';
import 'package:maslaha/core/constants/api_constants.dart';
import 'package:maslaha/core/services/device_info/device_info.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/forgot_password/repository/forgot_password_repository_impl.dart';
import 'package:maslaha/forgot_password/repository/i_forgot_password_repository.dart';
import 'package:maslaha/forgot_password/view_model/forgot_password_cubit.dart';
import 'package:maslaha/initial_preferences/model/datasource/local/local_data_source.dart';
import 'package:maslaha/initial_preferences/repository/i_initial_preferences_repository.dart';
import 'package:maslaha/initial_preferences/view-model/initial_preferences_cubit.dart';
import 'package:maslaha/sign_in/model/datasources/remote/remote_data_source.dart';
import 'package:maslaha/sign_in/repository/i_login_repository.dart';
import 'package:maslaha/sign_in/repository/login_repository_impl.dart';
import 'package:maslaha/sign_in/view_model/login_view_model/login_cubit.dart';
import 'package:maslaha/sign_up/repository/i_signup_repository.dart';
import 'package:maslaha/sign_up/repository/signup_repository_impl.dart';
import 'package:maslaha/sign_up/view_model/signup_cubit.dart';
import '../../forgot_password/model/remote/remote_data_source.dart';
import '../../initial_preferences/repository/initial_preferences_repository_impl.dart';
import '../../sign_up/model/datasources/remote/remote_data_source.dart';
import '../MVVM/model/remote/token_verification_remote_data_source.dart';
import '../MVVM/view_model/app_state_cubit.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

class ServicesLocator{

  void init(){
    //Dio
    sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      //TODO: change duration
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )));

    // Internet Connection Checker
    sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());

    // NetworkImpl
    sl.registerLazySingleton<INetworkInfo>(() => ICCNetworkInfo(sl()));

    //device_info
    sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
    sl.registerLazySingleton<IDeviceInfo>(() => DIPDeviceInfo(sl()));

    //Flutter_Secured_Storage
    sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        )
    ));
    sl.registerSingleton<ISecuredStorageData>(FSSSecuredStorageData(sl()));




    //Data sources
    sl.registerLazySingleton<ILoginRemoteDataSource>(() => APILoginRemoteDataSource(sl()));
    sl.registerLazySingleton<ISignupRemoteDataSource>(() => APISignupRemoteDataSource(sl()));
    sl.registerLazySingleton<ITokenVerificationRemoteDataSource>(() => APITokenVerificationRemoteDataSource());
    sl.registerLazySingleton<IInitialPrefsLocalDataSource>(() => FSSInitialPrefsLocalDataSource(sl()));
    sl.registerLazySingleton<ITokenVerificationLocalDataSource>(() => FSSTokenVerificationLocalDataSource(sl()));
    sl.registerLazySingleton<IForgotPasswordRemoteDataSource>(() => APIForgotPasswordRemoteDataSource());


    //repository
    sl.registerLazySingleton<ILoginRepository>(() => LoginRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<ISignupRepository>(() => SignupRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<IInitialPreferencesRepository>(() => InitialPreferencesRepositoryImpl(sl()));
    sl.registerLazySingleton<ITokenVerificationRepository>(() => TokenVerificationRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<IForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(sl(), sl()));


    //bloc
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl(),),);
    sl.registerFactory<SignupCubit>(() => SignupCubit(sl(),),);
    sl.registerLazySingleton<InitialPreferencesCubit>(() => InitialPreferencesCubit(sl(),),);
    sl.registerLazySingleton<AppStateCubit>(() => AppStateCubit(sl(),),);
    sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(sl(),),);
    sl.registerFactory<UiCubit>(() => UiCubit());
    //TODO: add new blocs
  }
}