part of 'add_pledge_cubit.dart';

@immutable
sealed class AddPledgeState {}

final class AddPledgeInitial extends AddPledgeState {}
final class AddPledgeLoading extends AddPledgeState {}
final class AddPledgeSuccess extends AddPledgeState {

}
final class AddPledgeError extends AddPledgeState {}
