part of 'delete_gift_for_event_cubit.dart';

@immutable
sealed class DeleteGiftForEventState {}

final class DeleteGiftForEventInitial extends DeleteGiftForEventState {}
final class DeleteGiftForEventLoading extends DeleteGiftForEventState {}
final class DeleteGiftForEventLoaded extends DeleteGiftForEventState {}
final class DeleteGiftForEventError extends DeleteGiftForEventState {}
