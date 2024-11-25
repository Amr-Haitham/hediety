part of 'set_app_user_cubit.dart';

@immutable
sealed class SetAppUserState {}

final class SetAppUserInitial extends SetAppUserState {}

final class SetAppUserLoaded extends SetAppUserState {
  final AppUser appUser;

  SetAppUserLoaded({required this.appUser});
}

final class SetAppUserLoading extends SetAppUserState {}

final class SetAppUserError extends SetAppUserState {
  final String errorMessage;
  SetAppUserError({this.errorMessage = ConstantText.generalErrorMessage});
}
