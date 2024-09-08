import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/features/favorites/domain/model/favorites_model.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitial());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  FavoritesRepository favoritesRepository =
      FavoritesRepository(locator<DioService>());

  getFavoritesData() async {
    emit(GetFavoritesDataLoadingState());
    final response = await favoritesRepository.favoritesDataRepo();

    if (response != null) {
      print("here");
      print(FavoritesModel.fromJson(response).data!.item!.length);
      emit(GetFavoritesDataSuccessState(
          data: FavoritesModel.fromJson(response)));
      return true;
    } else {
      emit(GetFavoritesDataErrorState());
      return null;
    }
  }

  toggleLike({required String id}) async {
    emit(ToggleFAVLoadingState());
    final response = await favoritesRepository.toggleFavRepo(id: id);
    if (response != null) {
      emit(ToggleFAVSuccessState());
      return true;
    } else {
      emit(ToggleFAVErrorState());
      return null;
    }
  }
}
