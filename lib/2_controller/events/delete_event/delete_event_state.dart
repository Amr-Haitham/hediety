part of 'delete_event_cubit.dart';

@immutable
sealed class DeleteEventState {}

final class DeleteEventInitial extends DeleteEventState {}

final class DeleteEventLoading extends DeleteEventState {}

final class DeleteEventLoaded extends DeleteEventState {
  final String eventId;
  DeleteEventLoaded({required this.eventId});
}

final class DeleteEventError extends DeleteEventState {}
