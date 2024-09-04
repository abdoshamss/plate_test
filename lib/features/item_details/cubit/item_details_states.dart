import '../domain/model/item_details_model.dart';

abstract class ItemDetailsStates {}

class ItemDetailsInitial extends ItemDetailsStates {}

class GetItemDetailsDataLoading extends ItemDetailsStates {}

class GetItemDetailsDataSuccess extends ItemDetailsStates {
  ItemDetailsModel data;

  GetItemDetailsDataSuccess({required this.data});
}

class GetItemDetailsDataError extends ItemDetailsStates {}
