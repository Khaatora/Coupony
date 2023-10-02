
import 'package:flutter/material.dart';
import 'package:maslaha/core/home_layout/view/home_layout.dart';
import 'package:maslaha/forgot_password/view/forgot_password_screen.dart';
import 'package:maslaha/initial_preferences/view/initial_preferences_screen.dart';
import 'package:maslaha/settings/views/settings_screen.dart';
import 'package:maslaha/sign_in/view/login_screen.dart';

import '../../sign_up/view/signup_screen.dart';

/// use this class for route names
class Routes{

  static const home = "/";
  static const login = "/login";
  static const signup = "/signup";
  static const forgotPassword = "/forgotPassword";
  static const initInfo = "/initInfo"; // page view screen that contains stores, language and region info
  static const settings = "/settings";

  static Route<dynamic>? generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case login:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const LoginScreen(),);
      case forgotPassword:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const ForgotPasswordScreen(),);
      case signup:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const SignupScreen(),);
      case initInfo:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const InitialPreferencesScreen(),);
      case home:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const HomeLayout(),);
      case settings:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const SettingsScreen(),);
      default:
        return null;
    }
  }
}