import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/notifications_model.dart';
import '../domain/repository/repository.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  NotificationsRepository notificationsRepository =
      NotificationsRepository(locator<DioService>());

  PagingController<int, NotificationModel> notificationController =
      PagingController<int, NotificationModel>(firstPageKey: 1);

  addPageListener() async {
    notificationController.addPageRequestListener((pageKey) {
      getNotification(page: pageKey);
    });
  }

  getNotification({required int page}) async {
    final NotificationPagination? res =
        await notificationsRepository.getNotifications(
      page,
    );
    if (res != null) {
      var isLastPage = res.page == page;

      if (isLastPage) {
        notificationController.appendLastPage(res.notification ?? []);
      } else {
        var nextPageKey = page + 1;
        notificationController.appendPage(res.notification ?? [], nextPageKey);
      }
    } else {
      notificationController.error = 'error';
    }
  }
}
