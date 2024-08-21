import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'item_details_states.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsStates> {
  ItemDetailsCubit() : super(ItemDetailsInitial());
  static ItemDetailsCubit get(context) => BlocProvider.of(context);
  
 ItemDetailsRepository item_detailsRepository =  ItemDetailsRepository(locator<DioService>());
}