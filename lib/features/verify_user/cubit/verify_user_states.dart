abstract class VerifyUserStates {}

class VerifyUserInitial extends VerifyUserStates {}

class VerifyUserLoading extends VerifyUserStates {}

class VerifyUserSuccess extends VerifyUserStates {
  final String? message;

  VerifyUserSuccess({required this.message});
}

class VerifyUserError extends VerifyUserStates {}
