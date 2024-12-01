part of 'get_gifts_for_event_cubit.dart';

@immutable
sealed class GetGiftsForEventState {}

final class GetGiftsForEventInitial extends GetGiftsForEventState {}

final class GetGiftsForEventLoading extends GetGiftsForEventState {}

final class GetGiftsForEventLoaded extends GetGiftsForEventState {
  final List<Gift> gifts;
  GetGiftsForEventLoaded({required this.gifts});
}

final class GetGiftsForEventError extends GetGiftsForEventState {}
