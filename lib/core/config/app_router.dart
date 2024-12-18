import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/1_view/all_users_screen/all_users_screen.dart';
import 'package:hediety/2_controller/add_pledge/add_pledge_cubit.dart';
import 'package:hediety/2_controller/follow_un_follow/follow_unfollow_cubit.dart';
import 'package:hediety/2_controller/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:hediety/2_controller/get_latest_events_for_friends/get_latest_events_for_friends_cubit.dart';
import 'package:hediety/2_controller/get_my_pledges/get_my_pledges_cubit.dart';
import 'package:hediety/2_controller/get_pledge_status_for_gift/get_pledge_status_for_gift_cubit.dart';
import 'package:hediety/2_controller/get_single_app_user/get_single_appuser_cubit.dart';
import 'package:hediety/1_view/list_management_feature/1_presentation/gifts_list_screen.dart';
import 'package:hediety/1_view/list_of_events_features/1_presentation/event_form_screen.dart';
import 'package:hediety/1_view/list_of_events_features/1_presentation/my_events_screen.dart';
import 'package:hediety/1_view/pledged_by_me_feature/1_presentation/pledged_by_me_screen.dart';
import 'package:hediety/2_controller/app_user_blocs/get_app_user_cubit/get_app_user_cubit.dart';
import 'package:hediety/2_controller/app_user_blocs/set_app_user_cubit/set_app_user_cubit.dart';
import 'package:hediety/2_controller/events/delete_event/delete_event_cubit.dart';
import 'package:hediety/2_controller/events/get_user_events/get_user_events_cubit.dart';
import 'package:hediety/2_controller/events/set_event/set_event_cubit.dart';
import 'package:hediety/2_controller/gifts_blocs/delete_gift_for_event/delete_gift_for_event_cubit.dart';
import 'package:hediety/2_controller/gifts_blocs/get_gifts_for_event/get_gifts_for_event_cubit.dart';
import 'package:hediety/2_controller/gifts_blocs/set_gift_for_event/set_gift_for_event_cubit.dart';
import 'package:hediety/3_data_layer/models/event.dart';
import 'package:hediety/3_data_layer/models/gift.dart';
import '../../2_controller/get_all_friends/get_all_friends_cubit.dart';
import '../../1_view/set_gift_screen/1_presentation/set_gift_screen.dart';
import '../../1_view/authentication/presentation/manager/authentication_cubit/authentication_cubit.dart';
import '../../1_view/authentication/presentation/manager/authentication_op/authentication_op_cubit.dart';
import '../../1_view/authentication/presentation/pages/auth_wrapper.dart';
import '../../1_view/authentication/presentation/pages/sign_in_screen.dart';
import '../../1_view/authentication/presentation/pages/sign_up_screen.dart';
import '../../1_view/home_screen/1_presentation/home_screen.dart';
import '../../1_view/notifications_screen/notifications_screen.dart';
import '../../1_view/profile_feature/1_presentation/profile_screen.dart';
import '../utils/auth_utils.dart';

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
  static const String setGiftsScreenRoute = 'set_gifts_screen_route';
  static const String pledgedByMeScreenRoute = 'pledged_by_me_screen_route';
  static const String notificationsScreenRoute = 'notificaitons_screen_route';
  static const String allUsersScreenRoute = 'all_users_screen_route';
}

class AppRouter {
  //AppRouter._();

  final SetEventCubit _setEventCubit = SetEventCubit();
  final SetGiftForEventCubit _setGiftForEventCubit = SetGiftForEventCubit();
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
                    homeScreen: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => GetLatestEventsForFriendsCubit(),
                        ),
                        BlocProvider(
                          create: (context) => GetSingleAppuserCubit(),
                        ),
                      ],
                      child: HomeScreen(),
                    ),
                    signInScreen: BlocProvider(
                      create: (context) => AuthenticationOpCubit(),
                      child: const SignInScreen(),
                    ),
                  ),
                ));
      case Routes.allUsersScreenRoute:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetAllUsersCubit(),
                    ),
                    BlocProvider(
                      create: (context) => GetAllFriendsCubit(),
                    ),
                    BlocProvider(
                      create: (context) => FollowUnfollowCubit(),
                    ),
                  ],
                  child: AllUsersScreen(),
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
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GetSingleAppuserCubit(),
                  child: ProfileScreen(),
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

      case Routes.giftsListScreenRoute:
        Event event = settings.arguments as Event;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetGiftsForEventCubit(),
                    ),
                    BlocProvider(
                      create: (context) => DeleteGiftForEventCubit(),
                    ),
                    BlocProvider.value(
                      value: _setGiftForEventCubit,
                    ),
                  ],
                  child: GiftsListScreen(
                    event: event,
                    isMyList: event.userId == AuthUtils.getCurrentUserUid(),
                  ),
                ));

      case Routes.setGiftsScreenRoute:
        Map mapWithGiftAndEventId = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _setGiftForEventCubit,
                    ),
                    BlocProvider(
                      create: (context) => GetPledgeStatusForGiftCubit(),
                    ),
                    BlocProvider(
                      create: (context) => AddPledgeCubit(),
                    ),
                  ],
                  child: GiftFormScreen(
                    isMyGift: mapWithGiftAndEventId['isMyGift'] ?? true,
                    gift: mapWithGiftAndEventId['gift'],
                    eventId: mapWithGiftAndEventId['eventId'],
                  ),
                ));
      case Routes.pledgedByMeScreenRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GetMyPledgesCubit(),
                  child: PledgedByMeScreen(),
                ));
      case Routes.notificationsScreenRoute:
        return MaterialPageRoute(builder: (context) => NotificationScreen());

      // default:
      //   return MaterialPageRoute(builder: (context) => initialRoute);
    }
    return null;
  }
}
