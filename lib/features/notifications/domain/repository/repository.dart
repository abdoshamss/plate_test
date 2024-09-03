import '../../../../core/data_source/dio_helper.dart';
import '../model/notifications_model.dart';

//put it in locators locator.registerLazySingleton(() => NotificationsRepository(locator<DioService>()));
//  import '../../modules/notifications/domain/repository/repository.dart';
class NotificationsRepository {
  final DioService dioService;

  NotificationsRepository(this.dioService);

  getNotifications(int? page) async {
    final ApiResponse res = await dioService.getData(
      url: "/notifications",
      query: {"page": page},
    );

    if (res.isError == false) {
      return NotificationPagination.fromMap(res.response?.data);
    } else {
      return null;
    }
  }
}
