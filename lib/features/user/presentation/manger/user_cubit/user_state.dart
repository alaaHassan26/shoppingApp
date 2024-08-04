part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class SignInLoading extends UserState {}

final class SignInSuccess extends UserState {
  final String message;

  SignInSuccess({required this.message});
}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignUpLoading extends UserState {}

final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class ProfileLoading extends UserState {}

final class ProfileSuccess extends UserState {
  final UserProfileModel user;

  ProfileSuccess({required this.user});
}

final class ProfileFailure extends UserState {
  final String errMessage;

  ProfileFailure({required this.errMessage});
}

final class UpdateProfileLoading extends UserState {}

final class UpdateProfileSuccess extends UserState {
  final UpdateProfileModel user;

  UpdateProfileSuccess({required this.user});
}

final class UpdateProfileFailure extends UserState {
  final String errMessage;

  UpdateProfileFailure({required this.errMessage});
}

final class UploadProfilePic extends UserState {}

class LogoutLoading extends UserState {}

class LogoutSuccess extends UserState {
  final String message;

  LogoutSuccess({required this.message});
}

class LogoutFailure extends UserState {
  final String error;
  LogoutFailure({required this.error});
}

class SignInFormError extends UserState {
  final String? emailError;
  final String? passwordError;

  SignInFormError({this.emailError, this.passwordError});
}

class SignUpFormError extends UserState {
  final String? nameError;
  final String? emailError;
  final String? passwordError;

  SignUpFormError({this.nameError, this.emailError, this.passwordError});
}

final class ProfilePicErrorCleared extends UserState {}
