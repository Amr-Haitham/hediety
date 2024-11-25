import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../1_features/authentication/presentation/manager/authentication_cubit/authentication_cubit.dart';
import '../../1_features/authentication/presentation/pages/auth_wrapper.dart';
import '../../1_features/authentication/presentation/pages/sign_in_screen.dart';
import '../../1_features/authentication/presentation/pages/sign_up_screen.dart';

class Routes {
  // static const String rootRoute = '/';
  static const String authWrapper = "/";
  // static const String onboardingRoute = 'onboarding_screen_route';
  static const String signInRoute = 'sign_in_screen_route';
  static const String signUpRoute = 'sign_up_screen_route';
}

class AppRouter {
  //AppRouter._();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.authWrapper:
        return MaterialPageRoute(
            builder: (context) => AuthWrapper(homeScreen: Text("home screen")));
    }
    return null;
  }
}
