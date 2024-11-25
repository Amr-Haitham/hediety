part of 'delete_app_user_cubit.dart';

@immutable
sealed class DeleteAppUserState {}

final class DeleteAppUserInitial extends DeleteAppUserState {}

final class DeleteAppUserLoading extends DeleteAppUserState {}

final class DeleteAppUserLoaded extends DeleteAppUserState {}

final class DeleteAppUserError extends DeleteAppUserState {
  final String errorMessage;

  DeleteAppUserError({this.errorMessage = ConstantText.generalErrorMessage});
}
