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
}
