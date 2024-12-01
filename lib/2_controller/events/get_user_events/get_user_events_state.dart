part of 'get_user_events_cubit.dart';

@immutable
sealed class GetUserEventsState {}

final class GetUserEventsInitial extends GetUserEventsState {}
final class GetUserEventsLoading extends GetUserEventsState {}
final class GetUserEventsLoaded extends GetUserEventsState {
  final List<Event> events;
  GetUserEventsLoaded({required this.events});
}
final class GetUserEventsError extends GetUserEventsState {}
