import '../../auth/domain/model/auth_model.dart';
import '../domain/model/profile_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class LogOutLoading extends ProfileStates {}

class LogOutSuccess extends ProfileStates {}

class LogOutError extends ProfileStates {}

class DeleteAccountLoading extends ProfileStates {}

class DeleteAccountSuccess extends ProfileStates {}

class DeleteAccountError extends ProfileStates {}

class GetProfileDataLoading extends ProfileStates {}

class GetProfileDataSuccess extends ProfileStates {
  final ProfileUser user;

  GetProfileDataSuccess({required this.user});
}

class GetProfileDataError extends ProfileStates {}

class EditProfileLoadingState extends ProfileStates {}

class EditProfileSuccessState extends ProfileStates {}

class EditProfileErrorState extends ProfileStates {}

class EditPasswordLoadingState extends ProfileStates {}

class EditPasswordSuccessState extends ProfileStates {}

class EditPasswordErrorState extends ProfileStates {}

final class ActivateMobileLoading extends ProfileStates {}

final class ActivateMobileLoaded extends ProfileStates {
  final UserModel userModel;

  ActivateMobileLoaded(this.userModel);
}

final class ActivateMobileError extends ProfileStates {}

final class ResendCodeLoading extends ProfileStates {}

final class ResendCodeSuccess extends ProfileStates {}

final class ResendCodeError extends ProfileStates {}

final class MobileChanged extends ProfileStates {}
