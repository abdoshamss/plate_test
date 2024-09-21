import '../../../../core/data_source/dio_helper.dart';
import 'endpoints.dart';

//put it in locators locator.registerLazySingleton(() => SettingsRepository(locator<DioService>()));
//  import '../../modules/settings/domain/repository/repository.dart';
class SettingsRepository {
  final DioService dioService;

  SettingsRepository(this.dioService);

  notificationToggleRepo() async {
    final response = await dioService.postData(
        isForm: true,
        url: SettingsEndpoints.toggleNotifications,
        loading: true);
    if (response.isError == false) {
      return response.response?.data["message"];
    } else {
      return null;
    }
  }

  chargeWallet(String? amount) async {
    final ApiResponse respons = await dioService.postData(
      url: "/charge",
      loading: true,
      isForm: true,
      body: {
        "amount": amount,
      },
    );
    if (respons.isError == false) {
      return respons.response?.data["data"];
    } else {
      return null;
    }
  }
}
