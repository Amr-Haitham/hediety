import 'package:bloc/bloc.dart';
import 'package:hediety/3_data_layer/repo/appuser_firestore_repo.dart';
import 'package:hediety/3_data_layer/repo/friendship_repo.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/friend.dart';

part 'follow_unfollow_state.dart';

class FollowUnfollowCubit extends Cubit<FollowUnfollowState> {
  FollowUnfollowCubit() : super(FollowUnfollowInitial());
  final FriendshipRepo _friendshipRepo = FriendshipRepo();
  void addFriend({required Friend friend}) async {
    emit(FollowUnfollowLoading());
    try {
      await _friendshipRepo.addFriend(friend: friend);
      emit(FollowUnfollowSuccess());
    } catch (e) {
      emit(FollowUnfollowError());
    }
  }

  void removeFriend({required String friendId}) async {
    emit(FollowUnfollowLoading());
    try {
      var friends = await _friendshipRepo.getAllFriends();
      Friend friend =
          friends.firstWhere((friend) => friend.friendId == friendId);
      await _friendshipRepo.removeFriend(id: friend.id);
      emit(FollowUnfollowSuccess());
    } catch (e) {
      emit(FollowUnfollowError());
    }
  }
}
