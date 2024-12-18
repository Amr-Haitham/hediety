import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:hediety/3_data_layer/repo/events_repo.dart';
import 'package:hediety/3_data_layer/repo/friends_repo.dart';
import 'package:hediety/3_data_layer/repo/gifts_repo.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/event.dart';
import '../../core/utils/auth_utils.dart';

part 'get_latest_events_for_friends_state.dart';

class GetLatestEventsForFriendsCubit
    extends Cubit<GetLatestEventsForFriendsState> {
  GetLatestEventsForFriendsCubit() : super(GetLatestEventsForFriendsInitial());
  final String _userId = AuthUtils.getCurrentUserUid();
  final EventsRepo _eventsRepo = EventsRepo();
  final FriendsRepo _friendsRepo = FriendsRepo();
  void getLatestEventsForFriends() async {
    emit(GetLatestEventsForFriendsLoading());
    try {
      var allMyFriends =
          await _friendsRepo.getAllFriendsForAppUser(uid: _userId);
      Map<AppUser, Event> friendToEvent = {};
      for (var friend in allMyFriends) {
        List<Event> value =
            await _eventsRepo.getAllEventsForAppUser(uid: friend.id);
        if (value.isNotEmpty) {
          value.sort((a, b) => b.date.toDate().compareTo(a.date.toDate()));

          friendToEvent[friend] = value.first;
        }
      }
      print(friendToEvent);

      emit(GetLatestEventsForFriendsLoaded(friendToEvent: friendToEvent));
    } catch (e) {
      emit(GetLatestEventsForFriendsError());
    }
  }
}
