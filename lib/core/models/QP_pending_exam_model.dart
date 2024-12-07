

class QpExamsModel {
  dynamic id;
  dynamic gradeId;
  dynamic subId;
  String? examName;
  String? examYear;
  String? createdAt;
  String? updatedAt;
  dynamic isLocked;

  QpExamsModel({this.id, this.gradeId, this.subId, this.examName, this.examYear, this.createdAt, this.updatedAt,this.isLocked});

  QpExamsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    subId = json["sub_id"];
    examName = json["exam_name"];
    examYear = json["exam_year"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    isLocked=json['is_locked'];
  }

  static List<QpExamsModel> fromList(List<dynamic> list) {
    return list.map((map) => QpExamsModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["grade_id"] = gradeId;
    data["sub_id"] = subId;
    data["exam_name"] = examName;
    data["exam_year"] = examYear;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data['is_locked']=isLocked;
    return data;
  }
}