import '../domain/model/favorites_model.dart';

abstract class FavoritesStates {}

class FavoritesInitial extends FavoritesStates {}

class GetFavoritesDataLoadingState extends FavoritesStates {}

class GetFavoritesDataSuccessState extends FavoritesStates {
  FavoritesModel? data;

  GetFavoritesDataSuccessState({this.data});
}

class GetFavoritesDataErrorState extends FavoritesStates {}

class ToggleFAVLoadingState extends FavoritesStates {}

class ToggleFAVSuccessState extends FavoritesStates {}

class ToggleFAVErrorState extends FavoritesStates {}
