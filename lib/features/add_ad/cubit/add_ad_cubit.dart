import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/features/add_ad/domain/request/add_ad_request.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'add_ad_states.dart';

class AddAdCubit extends Cubit<AddAdStates> {
  AddAdCubit() : super(AddAdInitial());

  static AddAdCubit get(context) => BlocProvider.of(context);

  AddAdRepository addAdRepository = AddAdRepository(locator<DioService>());

  addAdd({required AddAdRequest addAdRequest}) async {
    emit(AddAdLoadingStates());
    final response = await addAdRepository.addAd(addAdRequest);
    if (response != null) {
      if (response["item"] == null) {
        emit(AddAdErrorStates());
        return false;
      } else {
        print("response" * 88);
        print(response);

        emit(AddAdSuccessStates());
        return true;
      }
    } else {
      emit(AddAdErrorStates());
      return null;
    }
  }

  orderCharge() async {
    emit(OrderChargeLoadingStates());
    final response = await addAdRepository.orderCharge();

    if (response != null) {
      if (response["charge_link"] == null) {
        emit(OrderChargeErrorStates());
        return false;
      } else {
        emit(OrderChargeSuccessStates(chargeLink: response["charge_link"]));
        return true;
      }
    } else {
      emit(OrderChargeErrorStates());
      return null;
    }
  }

  String? Function(String?)? validatePlateNumber() {
    return (String? value) {
      if (value!.isEmpty) {
        return "Plate Number is required";
      } else if (value.length < 4 || value.length > 4) {
        return "Plate Number must be 4 numbers";
      }
      return null;
    };
  }

  String? Function(String? value) validateCodeNumber() {
    return (String? value) {
      if (value!.isEmpty) {
        return "Plate Code is required".tr();
      } else if (value.length < 3 || value.length > 3) {
        return "Plate Code must be 3 letters";
      }
      return null;
    };
  }
}
