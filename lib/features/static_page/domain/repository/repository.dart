import '../../../../core/data_source/dio_helper.dart';

class StaticPageRepository {
  final DioService dioService;

  StaticPageRepository(this.dioService);

  getAbout() async {
    final ApiResponse response = await dioService.getData(
      url: "/pages/about",
      // loading: true,
    );
    if (response.isError == false) {
      return response.response?.data["data"]["page"];
    } else {
      return null;
    }
  }
 
  getPolicy() async {
    final ApiResponse response = await dioService.getData(
      url: "/pages/policy",
      // loading: true,
    );
    if (response.isError == false) {
      return response.response?.data["data"]["page"];
    } else {
      return null;
    }
  }

  getFaqs() async {
    final ApiResponse response = await dioService.getData(
      url: "/pages/faqs",
      // loading: true,
    );
    if (response.isError == false) {
      return response.response?.data["data"];
    } else {
      return null;
    }
  }

  getcontactus() async {
    final ApiResponse response = await dioService.getData(
      url: "/contactus",
      // loading: true,
    );
    if (response.isError == false) {
      return response.response?.data["data"];
    } else {
      return null;
    }
  }
}
