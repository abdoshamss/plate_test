import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitial());
  static FavoritesCubit get(context) => BlocProvider.of(context);
  
 FavoritesRepository favoritesRepository =  FavoritesRepository(locator<DioService>());
}