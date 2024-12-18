part of 'get_single_appuser_cubit.dart';

@immutable
sealed class GetSingleAppuserState {}

final class GetSingleAppuserInitial extends GetSingleAppuserState {}
final class GetSingleAppuserLoading extends GetSingleAppuserState {}
final class GetSingleAppuserLoaded extends GetSingleAppuserState {
  final AppUser appUser;
  GetSingleAppuserLoaded({required this.appUser});
}
final class GetSingleAppuserError extends GetSingleAppuserState {}
