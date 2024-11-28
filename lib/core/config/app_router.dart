import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/1_features/list_management_feature/1_presentation/list_management_screen.dart';
import 'package:hediety/1_features/my_lists_screen/1_presentation/my_lists_screen.dart';
import 'package:hediety/1_features/pledged_by_me_feature/1_presentation/pledged_by_me_screen.dart';
import 'package:hediety/2_global_bloc_layer/app_user_blocs/get_app_user_cubit/get_app_user_cubit.dart';
import 'package:hediety/2_global_bloc_layer/app_user_blocs/set_app_user_cubit/set_app_user_cubit.dart';
import '../../1_features/add_item_screen/1_presentation/add_item_screen.dart';
import '../../1_features/authentication/presentation/manager/authentication_cubit/authentication_cubit.dart';
import '../../1_features/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import '../../1_features/authentication/presentation/pages/auth_wrapper.dart';
import '../../1_features/authentication/presentation/pages/sign_in_screen.dart';
import '../../1_features/authentication/presentation/pages/sign_up_screen.dart';
import '../../1_features/home_screen/1_presentation/home_screen.dart';
import '../../1_features/notifications_screen/notifications_screen.dart';
import '../../1_features/profile_feature/1_presentation/profile_screen.dart';

class Routes {
  // static const String rootRoute = '/';
  static const String authWrapper = "/";
  // static const String onboardingRoute = 'onboarding_screen_route';
  // static const String signInRoute = 'sign_in_screen_route';
  static const String signUpRoute = 'sign_up_screen_route';
  static const String profileScreenRoute = 'profile_screen_route';
  static const String listManagementScreenRoute =
      'list_management_screen_route';
  static const String myListsScreenRoute = 'my_lists_screen_route';
  static const String addItemsScreenRoute = 'add_items_screen_route';
  static const String pledgedByMeScreenRoute = 'pledged_by_me_screen_route';
  static const String notificationsScreenRoute = 'notificaitons_screen_route';
}

class AppRouter {
  //AppRouter._();

  final GetAppUserCubit _getAppUserCubit = GetAppUserCubit();
  final AuthenticationCubit _authenticationCubit = AuthenticationCubit();
  // Widget initialRoute = const OnboardingScreen();
  // //
  // void setInitialRouteToLandingScreen() {
  //   initialRoute = const OnboardingScreen();
  // }

  // void setInitialRouteToHome() {
  //   initialRoute =  HomeScreen(setBillBoardCubit: _setBillBoardCubit, mainScreens: [],);
  // }
  // final SetBillBoardCubit _setBillBoardCubit = SetBillBoardCubit();
  // final DeleteBillBoardCubit _deleteBillBoardCubit = DeleteBillBoardCubit();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (context) =>  AuthUtilityFunctions.authenticationGateRouter());

      // case Routes.onboardingRoute:
      //   return MaterialPageRoute(
      //       builder: (context) => const OnboardingScreen());
      case Routes.authWrapper:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => AuthenticationCubit(),
                    ),
                  ],
                  child: AuthWrapper(
                    homeScreen: HomeScreen(),
                    signInScreen: BlocProvider(
                      create: (context) => AuthenticationOpCubit(),
                      child: SignInScreen(),
                    ),
                  ),
                ));

      case Routes.signUpRoute:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => AuthenticationOpCubit(),
                    ),
                    BlocProvider(
                      create: (context) => SetAppUserCubit(),
                    ),
                  ],
                  child: const SignUpScreen(),
                ));

      case Routes.profileScreenRoute:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case Routes.listManagementScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ListManagementScreen(
                  listTitle: 'My birthday',
                  listDate: '2023-01-01',
                ));
      case Routes.myListsScreenRoute:
        return MaterialPageRoute(builder: (context) => MyListsScreen());
      case Routes.addItemsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => AddItemScreen(
                  listTitle: "My birthday",
                ));
      case Routes.pledgedByMeScreenRoute:
        return MaterialPageRoute(builder: (context) => PledgedByMeScreen());
      case Routes.notificationsScreenRoute:
        return MaterialPageRoute(builder: (context) => NotificationScreen());

      // default:
      //   return MaterialPageRoute(builder: (context) => initialRoute);
    }
    return null;
  }
}
