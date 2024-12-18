part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState {}
final class GetAllUsersInitial extends GetAllUsersState {}
final class GetAllUsersLoading extends GetAllUsersState {}
final class GetAllUsersLoaded extends GetAllUsersState {
  final List<AppUser> users;
  GetAllUsersLoaded({required this.users});
}
final class GetAllUsersError extends GetAllUsersState {}
