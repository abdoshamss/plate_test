import '../../../../core/data_source/dio_helper.dart';
import '../../../../core/services/alerts.dart';
import '../../../auth/domain/repository/end_points.dart';
import '../../../auth/domain/request/auth_request.dart';
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
      return response.response?.data['status'];
    } else {
      return null;
    }
  }

  getProfileRequest() async {
    final response = await dioService.getData(
        url: ProfileEndpoints.getProfileData, loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future editProfileRepo(AuthRequest user) async {
    final response = await dioService.postData(
        isForm: true,
        isFile: true,
        url: ProfileEndpoints.editProfileData,
        body: user.editProfile(),
        loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future editPasswordRepo(AuthRequest user) async {
    final response = await dioService.postData(
        isForm: true,
        isFile: true,
        url: ProfileEndpoints.editPasswordData,
        body: {
          "old_password": user.password,
          "password": user.password_confirmation,
          // "mobile": user.phone
          // "mobile": "0512341234",
          // "code": "12345"
        },
        loading: true);
    if (response.isError == false) {
      Alerts.snack(
          text: response.response?.data["message"] ?? "Password Updated",
          state: SnackState.success);
      return response.response?.data;
    } else {
      return null;
    }
  }

  activateRequest(AuthRequest authRequest) async {
    final response = await dioService.postData(
      isForm: true,
      url: AuthEndPoints.activate,
      body: authRequest.activate(),
    );
    if (response.isError == false) {
      Alerts.snack(
          text: response.response?.data['message'], state: SnackState.success);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  resendCodeRequest(String mobile) async {
    final response = await dioService.postData(
        url: AuthEndPoints.resendCode, body: {'mobile': mobile}, isForm: true);
    if (response.isError == false) {
      // Alerts.snack(text: response.response?.data['message'], state: 1);
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
