import 'package:plate_test/features/favorites/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => FavoritesRepository(locator<DioService>()));
//  import '../../modules/favorites/domain/repository/repository.dart';
class FavoritesRepository {
  final DioService dioService;

  FavoritesRepository(this.dioService);

  Future favoritesDataRepo() async {
    final response = await dioService.getData(
      url: FavoritesEndpoints.favoritesItems,
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }
}
