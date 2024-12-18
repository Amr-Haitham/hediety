part of 'get_latest_events_for_friends_cubit.dart';

@immutable
sealed class GetLatestEventsForFriendsState {}

final class GetLatestEventsForFriendsInitial extends GetLatestEventsForFriendsState {}
final class GetLatestEventsForFriendsLoading extends GetLatestEventsForFriendsState {}
final class GetLatestEventsForFriendsLoaded extends GetLatestEventsForFriendsState {
  Map<AppUser, Event> friendToEvent;
  GetLatestEventsForFriendsLoaded({required this.friendToEvent});
}
final class GetLatestEventsForFriendsError extends GetLatestEventsForFriendsState {}
