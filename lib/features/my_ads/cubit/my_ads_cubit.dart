import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'my_ads_states.dart';

class MyAdsCubit extends Cubit<MyAdsStates> {
  MyAdsCubit() : super(MyAdsInitial());
  static MyAdsCubit get(context) => BlocProvider.of(context);
  
 MyAdsRepository my_adsRepository =  MyAdsRepository(locator<DioService>());
}