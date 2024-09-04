import '../domain/model/home_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class GetHomeDataLoading extends HomeStates {}

class GetHomeDataSuccess extends HomeStates {
  final HomeModel data;

  GetHomeDataSuccess(this.data);
}

class GetHomeDataError extends HomeStates {}
