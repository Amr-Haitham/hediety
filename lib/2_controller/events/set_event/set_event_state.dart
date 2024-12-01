part of 'set_event_cubit.dart';

@immutable
sealed class SetEventState {}

final class SetEventInitial extends SetEventState {}
final class SetEventLoading extends SetEventState {}
final class SetEventLoaded extends SetEventState {
  final Event event;
  SetEventLoaded({required this.event});
}
final class SetEventError extends SetEventState {}
