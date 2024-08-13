part of 'general_cubit.dart';



class AreasModel {
  late final List<AreaModel>? areas;

  AreasModel.fromJson(Map<String, dynamic> json) {
    areas =
        List.from(json['areas'] ?? []).map((e) => AreaModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _AreasModel = <String, dynamic>{};
    _AreasModel['areas'] = areas?.map((e) => e.toJson()).toList();
    return _AreasModel;
  }
}

class AreaModel {
  late final int? id;
  late final String? name, flag;

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    flag = json['flag'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _AreasModel = <String, dynamic>{};
    _AreasModel['id'] = id;
    _AreasModel['name'] = name;
    _AreasModel['flag'] = flag;
    return _AreasModel;
  }
}
