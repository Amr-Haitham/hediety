import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/1_view/list_management_feature/1_presentation/list_management_screen.dart';
import 'package:hediety/1_view/list_of_events_features/1_presentation/event_form_screen.dart';
import 'package:hediety/1_view/list_of_events_features/1_presentation/my_events_screen.dart';
import 'package:hediety/1_view/pledged_by_me_feature/1_presentation/pledged_by_me_screen.dart';
import 'package:hediety/2_controller/app_user_blocs/get_app_user_cubit/get_app_user_cubit.dart';
import 'package:hediety/2_controller/app_user_blocs/set_app_user_cubit/set_app_user_cubit.dart';
import 'package:hediety/2_controller/events/delete_event/delete_event_cubit.dart';
import 'package:hediety/2_controller/events/get_user_events/get_user_events_cubit.dart';
import 'package:hediety/2_controller/events/set_event/set_event_cubit.dart';
import 'package:hediety/3_model/models/event.dart';
import '../../1_view/add_item_screen/1_presentation/add_item_screen.dart';
import '../../1_view/authentication/presentation/manager/authentication_cubit/authentication_cubit.dart';
import '../../1_view/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import '../../1_view/authentication/presentation/pages/auth_wrapper.dart';
import '../../1_view/authentication/presentation/pages/sign_in_screen.dart';
import '../../1_view/authentication/presentation/pages/sign_up_screen.dart';
import '../../1_view/home_screen/1_presentation/home_screen.dart';
import '../../1_view/notifications_screen/notifications_screen.dart';
import '../../1_view/profile_feature/1_presentation/profile_screen.dart';

class Routes {
  // static const String rootRoute = '/';
  static const String authWrapper = "/";
  // static const String onboardingRoute = 'onboarding_screen_route';
  // static const String signInRoute = 'sign_in_screen_route';
  static const String signUpRoute = 'sign_up_screen_route';
  static const String profileScreenRoute = 'profile_screen_route';
  static const String giftsListScreenRoute = 'gifts_list_screen_route';
  static const String eventFormScreenRoute = 'event_form_screen_route';
  static const String myEventsScreenRoute = 'my_events_screen_route';
  static const String addGiftsScreenRoute = 'add_gifts_screen_route';
  static const String pledgedByMeScreenRoute = 'pledged_by_me_screen_route';
  static const String notificationsScreenRoute = 'notificaitons_screen_route';
}

class AppRouter {
  //AppRouter._();

  final SetEventCubit _setEventCubit = SetEventCubit();
  // final DeleteEventCubit _deleteEventCubit = DeleteEventCubit();
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
                      child: const SignInScreen(),
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
      case Routes.giftsListScreenRoute:
        Event event = settings.arguments as Event;
        return MaterialPageRoute(
            builder: (context) => ListManagementScreen(
                  event: event,
                ));
      case Routes.myEventsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetUserEventsCubit(),
                    ),
                    BlocProvider.value(
                      value: _setEventCubit,
                    ),
                    BlocProvider(
                      create: (context) => DeleteEventCubit(),
                    ),
                  ],
                  child: MyEventsScreen(),
                ));

      case Routes.eventFormScreenRoute:
        Event? event = settings.arguments as Event?;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _setEventCubit,
                  child: EventFormScreen(
                    event: event,
                  ),
                ));

      case Routes.addGiftsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const AddItemScreen(
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
