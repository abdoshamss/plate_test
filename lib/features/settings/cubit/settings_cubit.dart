import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);
  
 SettingsRepository settingsRepository =  SettingsRepository(locator<DioService>());
}