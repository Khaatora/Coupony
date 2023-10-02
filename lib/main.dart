import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maslaha/core/MVVM/repository/i_token_verification_repository.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/core/home_layout/view/home_layout.dart';
import 'package:maslaha/core/services/firebase/firebase_api.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/core/services/services_locator.dart';
import 'package:maslaha/forgot_password/view/forgot_password_screen.dart';
import 'package:maslaha/initial_preferences/view/initial_preferences_screen.dart';
import 'package:maslaha/settings/views/settings_screen.dart';
import 'package:maslaha/sign_in/view/login_screen.dart';
import 'package:maslaha/sign_up/view/signup_screen.dart';
import 'core/MVVM/model/app_state_model.dart';
import 'core/global/theme.dart';
import 'core/utils/enums/cache_enums.dart';
import 'core/utils/enums/token_enums.dart';
import 'firebase_options.dart';

late String route;

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // uncomment to simulate IOS behavior and uncomment theme's TargetPlatform
  // debugDefaultTargetPlatformOverride  = TargetPlatform.iOS;
  ServicesLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await sl<FirebaseApi>().initNotifications();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await sl<ISecuredStorageData>().deleteAll();
  final result = await sl<ITokenVerificationRepository>().validateToken();
  await FSSSecuredStorageData.cacheTmpCache();
  // sl<ISecuredStorageData>().readAll();
  result.fold(
      (l) => {l is ServerFailure ? route = Routes.login : Routes.initInfo},
      (r) => route = _determineRoute(r));
  log(route);
  //default device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // log(await sl<IDeviceInfo>().deviceInfo);
  // await Hive.initFlutter();
  // var box = await Hive.openBox('testBox');
  runApp(const MyApp());
}

String _determineRoute(AppStateModel state) {
  log("${state.cacheState}, ${state.tokenState}");
  switch (state.cacheState) {
    case CacheState.init:
    case CacheState.exists:
      switch (state.tokenState) {
        case TokenState.valid:
          return Routes.home;
        case TokenState.init:
        case TokenState.invalid:
          return Routes.login;
      }
    case CacheState.empty:
      return Routes.initInfo;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      initialRoute: Routes.home,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final routes = <String, WidgetBuilder>{
          Routes.login: (context) => const LoginScreen(),
          Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
          Routes.signup: (context) => const SignupScreen(),
          Routes.initInfo: (context) => const InitialPreferencesScreen(),
          Routes.home: (context) => const HomeLayout(),
          Routes.settings: (context) => const SettingsScreen(),
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    );
  }
}
