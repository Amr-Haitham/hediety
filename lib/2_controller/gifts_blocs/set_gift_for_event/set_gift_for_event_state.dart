part of 'set_gift_for_event_cubit.dart';

@immutable
sealed class SetGiftForEventState {}

final class SetGiftForEventInitial extends SetGiftForEventState {}
final class SetGiftForEventLoading extends SetGiftForEventState {}
final class SetGiftForEventLoaded extends SetGiftForEventState {}
final class SetGiftForEventError extends SetGiftForEventState {}
