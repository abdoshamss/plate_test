import 'endpoints.dart';

import '../model/settings_model.dart';
import '../../../../core/data_source/dio_helper.dart';

  //put it in locators locator.registerLazySingleton(() => SettingsRepository(locator<DioService>()));
//  import '../../modules/settings/domain/repository/repository.dart';
class SettingsRepository{
final  DioService dioService ;
  SettingsRepository(this.dioService);
}
