abstract class AddAdStates {}

class AddAdInitial extends AddAdStates {}

class AddAdLoadingStates extends AddAdStates {}

class AddAdSuccessStates extends AddAdStates {}

class AddAdErrorStates extends AddAdStates {}

class GetCategoryDataLoadingStates extends AddAdStates {}

class GetCategoryDataSuccessStates extends AddAdStates {}

class GetCategoryDataErrorStates extends AddAdStates {}

class GetPlateStyleDataLoadingStates extends AddAdStates {}

class GetPlateStyleDataSuccessStates extends AddAdStates {}

class GetPlateStyleDataErrorStates extends AddAdStates {}

class OrderChargeLoadingStates extends AddAdStates {}

class OrderChargeSuccessStates extends AddAdStates {
  final String chargeLink;

  OrderChargeSuccessStates({required this.chargeLink});
}

class OrderChargeErrorStates extends AddAdStates {}
