import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  
 NotificationsRepository notificationsRepository =  NotificationsRepository(locator<DioService>());
}