import '../../../../core/data_source/dio_helper.dart';
import 'endpoints.dart';

//put it in locators locator.registerLazySingleton(() => ProfileRepository(locator<DioService>()));
//  import '../../modules/profile/domain/repository/repository.dart';
class ProfileRepository {
  final DioService dioService;

  ProfileRepository(this.dioService);

  logOutRepo(String uuid) async {
    final response = await dioService.postData(
        isForm: true,
        url: ProfileEndpoints.logOut,
        body: {"uuid": uuid},
        loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
