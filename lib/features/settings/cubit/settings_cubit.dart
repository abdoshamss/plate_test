import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/services/alerts.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  SettingsRepository settingsRepository =
      SettingsRepository(locator<DioService>());

  notificationToggle() async {
    emit(NotificationToggleSettingsLoading());
    final response = await settingsRepository.notificationToggleRepo();
    if (response != null) {
      emit(NotificationToggleSettingsSuccess());
      Alerts.snack(text: response, state: SnackState.success);
      return true;
    } else {
      emit(NotificationToggleSettingsError());
      Alerts.snack(text: response ?? "failed", state: SnackState.failed);
      return null;
    }
  }

  getWalletData() async {
    emit(GetWalletDataLoading());
    final response = await settingsRepository.notificationToggleRepo();
    if (response != null) {
      emit(GetWalletDataSuccess(balance: response["balance"]));
      // Alerts.snack(text: response, state: SnackState.success);
      return true;
    } else {
      emit(GetWalletDataError());
      // Alerts.snack(text: response ?? "failed", state: SnackState.failed);
      return null;
    }
  }

  Future<String?>? chargeWallet(String? amount) async {
    final res = await settingsRepository.chargeWallet(amount);
    if (res != null) {
      return res["charge_link"] as String;
    }
    return null;
  }
}
