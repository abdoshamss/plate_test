import '../data_source/dio_helper.dart';
import 'general_cubit.dart';

class GeneralRepo {
  final DioService dioService;

  GeneralRepo(this.dioService);

  Future<List<AreaModel>?> getAreas() async {
    List<AreaModel>? areas = [];
    if (areas.isNotEmpty) {
      return areas;
    }

    final response = await dioService.getData(url: 'areas');
    if (response.isError == false) {
      areas = AreasModel.fromJson(response.response!.data["data"]).areas ?? [];
      return areas;
    } else {
      return null;
    }
  }

  Future markAsSold(String id) async {
    final response = await dioService.postData(
        url: 'mark_as_solid', query: {'item_id': id}, loading: true);
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }
}
