part of 'get_all_friends_cubit.dart';

@immutable
sealed class GetAllFriendsState {}


final class GetAllFriendsInitial extends GetAllFriendsState {}
final class GetAllFriendsLoading extends GetAllFriendsState {}
final class GetAllFriendsLoaded extends GetAllFriendsState {
  final List<Friend> friends;
  GetAllFriendsLoaded({required this.friends});
}
final class GetAllFriendsError extends GetAllFriendsState {}
