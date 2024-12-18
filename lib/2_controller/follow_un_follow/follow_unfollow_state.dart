part of 'follow_unfollow_cubit.dart';

@immutable
sealed class FollowUnfollowState {}

final class FollowUnfollowInitial extends FollowUnfollowState {}

final class FollowUnfollowLoading extends FollowUnfollowState {}

final class FollowUnfollowSuccess extends FollowUnfollowState {
  FollowUnfollowSuccess();
}

final class FollowUnfollowError extends FollowUnfollowState {}
