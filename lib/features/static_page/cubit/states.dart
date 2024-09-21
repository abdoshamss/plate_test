abstract class StaticPageStates {}

class StaticPageInitial extends StaticPageStates {}

class ContactUsSendSuccess extends StaticPageStates {
  String message;

  ContactUsSendSuccess({required this.message});
}

final class StaticpagesAboutLoading extends StaticPageStates {}

final class StaticpagesAboutLoaded extends StaticPageStates {
  String? content;

  StaticpagesAboutLoaded({this.content});
// final StaticPageModel page;
//
// StaticpagesAboutLoaded(this.page);
}

final class StaticpagesAboutFailed extends StaticPageStates {}

final class StaticpagesPolicyFailed extends StaticPageStates {}

final class StaticpagesPolicyLoading extends StaticPageStates {}

final class StaticpagesPolicyLoaded extends StaticPageStates {
  // final StaticPageModel page;
  //
  // StaticpagesPolicyLoaded(this.page);
}

final class FaqLaodedState extends StaticPageStates {
  // final Questions questions;
  //
  // FaqLaodedState(this.questions);
}

final class FaqsLoading extends StaticPageStates {}

final class FaqsFailed extends StaticPageStates {}
