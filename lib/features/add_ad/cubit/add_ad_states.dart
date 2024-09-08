import '../domain/model/summary_model.dart';

abstract class AddAdStates {}

class AddAdInitial extends AddAdStates {}

class AddAdLoadingState extends AddAdStates {}

class AddAdSuccessState extends AddAdStates {}

class AddAdErrorState extends AddAdStates {}

class GetCategoryDataLoadingState extends AddAdStates {}

class GetCategoryDataSuccessState extends AddAdStates {}

class GetCategoryDataErrorState extends AddAdStates {}

class GetPlateStyleDataLoadingState extends AddAdStates {}

class GetPlateStyleDataSuccessState extends AddAdStates {}

class GetPlateStyleDataErrorState extends AddAdStates {}

class OrderChargeLoadingState extends AddAdStates {}

class OrderChargeSuccessState extends AddAdStates {
  final String chargeLink;

  OrderChargeSuccessState({required this.chargeLink});
}

class OrderChargeErrorState extends AddAdStates {}

class ValidateCouponLoadingState extends AddAdStates {}

class ValidateCouponSuccessState extends AddAdStates {}

class ValidateCouponErrorState extends AddAdStates {}

class GetSummaryLoadingState extends AddAdStates {}

class GetSummarySuccessState extends AddAdStates {
  SummaryModel? model;

  GetSummarySuccessState({this.model});
}

class GetSummaryErrorState extends AddAdStates {}
