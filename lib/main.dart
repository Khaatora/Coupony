import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maslaha/core/MVVM/view_model/app_state_cubit.dart';
import 'package:maslaha/core/constants/routes.dart';
import 'package:maslaha/core/services/services_locator.dart';
import 'package:maslaha/core/utils/enums/loading_enums.dart';
import 'package:maslaha/initial_preferences/view/initial_preferences_screen.dart';
import 'package:maslaha/sign_in/view/login_screen.dart';
import 'package:maslaha/sign_up/view/signup_screen.dart';

import 'core/global/theme.dart';
import 'core/utils/enums/cache_enums.dart';
import 'core/utils/enums/token_enums.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // log(await sl<IDeviceInfo>().deviceInfo);
  // await Hive.initFlutter();
  // var box = await Hive.openBox('testBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStateCubit>(
      create: (context) => sl<AppStateCubit>(),
      child: BlocBuilder<AppStateCubit, AppState>(
        buildWhen: (previous, current) =>
            current.loadingState == LoadingState.loaded ||
            current.loadingState == LoadingState.error,
        builder: (context, state) {
          return MaterialApp(
            initialRoute: _determineRoute(state),
            theme: AppTheme.light,
            routes: {
              Routes.login: (context) => const LoginScreen(),
              Routes.signup: (context) => const SignupScreen(),
              Routes.initInfo: (context) => const InitialPreferencesScreen(),
            },
          );
        },
      ),
    );
  }

  String _determineRoute(AppState state) {
    switch (state.appStateModel.cacheState) {
      case CacheState.init:
      case CacheState.exists:
        switch (state.appStateModel.tokenState) {
          case TokenState.init:
          case TokenState.valid:
            return Routes.home;
          case TokenState.invalid:
            return Routes.login;
        }
      case CacheState.empty:
        return Routes.initInfo;
    }
  }
}
