part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}
final class GetUserLoading extends GetUserState {}
final class GetUserNetworkError extends GetUserState {}
final class GetUserLoaded extends GetUserState {}
