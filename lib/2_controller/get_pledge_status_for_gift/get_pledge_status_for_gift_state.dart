part of 'get_pledge_status_for_gift_cubit.dart';

@immutable
sealed class GetPledgeStatusForGiftState {}

enum PledgeStatus { pledged, unpledged, done }

final class GetPledgeStatusForGiftInitial extends GetPledgeStatusForGiftState {}

final class GetPledgeStatusForGiftLoading extends GetPledgeStatusForGiftState {}

final class GetPledgeStatusForGiftSuccess extends GetPledgeStatusForGiftState {
  final PledgeStatus pledgeStatus;
  final String giftOnwerID;
  GetPledgeStatusForGiftSuccess({required this.pledgeStatus, required this.giftOnwerID});
}

final class GetPledgeStatusForGiftError extends GetPledgeStatusForGiftState {}
