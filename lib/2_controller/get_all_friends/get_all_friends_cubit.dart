import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../3_data_layer/models/friend.dart';
import '../../3_data_layer/repo/friendship_repo.dart';

part 'get_all_friends_state.dart';

class GetAllFriendsCubit extends Cubit<GetAllFriendsState> {
  GetAllFriendsCubit() : super(GetAllFriendsInitial());
  final FriendshipRepo _friendshipRepo = FriendshipRepo();
  void getAllFriends() async{
    try {
      emit(GetAllFriendsLoading());
      List<Friend> friends = await _friendshipRepo.getAllFriends();
      emit(GetAllFriendsLoaded(friends: friends));
    } catch (e) {
      emit(GetAllFriendsError());
    }
  }
}
