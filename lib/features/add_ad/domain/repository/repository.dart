import 'package:plate_test/features/add_ad/domain/model/list_data_model.dart';
import 'package:plate_test/features/add_ad/domain/request/add_ad_request.dart';

import '../../../../core/data_source/dio_helper.dart';
import 'endpoints.dart';

//put it in locators locator.registerLazySingleton(() => AddAdRepository(locator<DioService>()));
//  import '../../modules/add_ad/domain/repository/repository.dart';
class AddAdRepository {
  final DioService dioService;

  AddAdRepository(this.dioService);

  addAd(AddAdRequest data) async {
    final response = await dioService.postData(
        isForm: true,
        isFile: true,
        url: AddAdEndpoints.addAddEndPoint,
        body: data.requestMap(),
        loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future<Data?> getListData() async {
    final response = await dioService.getData(
      url: AddAdEndpoints.listData,
    );
    if (response.isError == false) {
      return Data.fromJson(response.response?.data['data']);
    } else {
      return null;
    }
  }

  Future orderCharge() async {
    final response = await dioService.postData(
        url: AddAdEndpoints.orderCharge, loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future validateCouponRepo(String coupon) async {
    final response = await dioService.postData(
        url: AddAdEndpoints.coupon, loading: true, body: {"coupon": coupon});
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  Future summaryRepo(String? coupon, int payWallet) async {
    final response = await dioService.getData(
        url: AddAdEndpoints.summary,
        loading: true,
        query: {"pay_wallet": payWallet, "coupon": coupon});
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
