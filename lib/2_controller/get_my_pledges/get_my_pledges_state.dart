part of 'get_my_pledges_cubit.dart';

@immutable
sealed class GetMyPledgesState {}

final class GetMyPledgesInitial extends GetMyPledgesState {}
final class GetMyPledgesLoading extends GetMyPledgesState {}
final class GetMyPledgesSuccess extends GetMyPledgesState {
  final List<PledgeDataEntity> pledges;
  GetMyPledgesSuccess({required this.pledges});
}
final class GetMyPledgesError extends GetMyPledgesState {}


class PledgeDataEntity{
  final Pledge pledge;
  final AppUser giftOwner;
  final Gift gift;
  PledgeDataEntity({required this.pledge, required this.giftOwner, required this.gift});
}