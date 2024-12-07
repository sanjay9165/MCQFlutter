
class GradeModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  GradeModel({this.id, this.name, this.createdAt, this.updatedAt});

  GradeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<GradeModel> fromList(List<dynamic> list) {
    return list.map((map) => GradeModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}