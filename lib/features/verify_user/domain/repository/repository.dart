import 'package:plate_test/features/verify_user/domain/repository/endpoints.dart';
import 'package:plate_test/features/verify_user/domain/request/verify_user_request.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => VerifyUserRepository(locator<DioService>()));
//  import '../../modules/verify_user/domain/repository/repository.dart';
class VerifyUserRepository {
  final DioService dioService;

  VerifyUserRepository(this.dioService);

  verifyRepo({required VerifyUserRequest verifyUserRequest}) async {
    print("verifyRepo");
    print(verifyUserRequest.verifyRequest());
    final response = await dioService.postData(
        isForm: true,
        url: VerifyUserEndpoints.verifyUser,
        isFile: true,
        body: await verifyUserRequest.verifyRequest(),
        loading: true);
    print(await verifyUserRequest.verifyRequest());
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }
}
