import '../domain/model/my_ads_model.dart';

abstract class MyAdsStates {}

class MyAdsInitial extends MyAdsStates {}

class GetMyAdsDataLoading extends MyAdsStates {}

class GetMyAdsDataSuccess extends MyAdsStates {
  MyAdsModel? date;

  GetMyAdsDataSuccess({this.date});
}

class GetMyAdsDataError extends MyAdsStates {}
