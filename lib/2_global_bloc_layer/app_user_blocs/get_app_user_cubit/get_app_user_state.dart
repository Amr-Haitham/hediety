part of 'get_app_user_cubit.dart';

@immutable
sealed class GetAppUserState {}

final class GetAppUserInitial extends GetAppUserState {}

final class GetAppUserLoading extends GetAppUserState {}

final class GetAppUserLoaded extends GetAppUserState {
  final AppUser appUser;

  GetAppUserLoaded({required this.appUser});
}

final class GetAppUserError extends GetAppUserState {
  final String errorMessage;

  GetAppUserError({this.errorMessage = ConstantText.generalErrorMessage});
}
