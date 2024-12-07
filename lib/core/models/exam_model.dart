//
//
//
// class ExamModel {
//   int? id;
//   int? gradeId;
//   int? subId;
//   String? examName;
//   String? examYear;
//   String? createdAt;
//   String? updatedAt;
//
//   ExamModel({this.id, this.gradeId, this.subId, this.examName, this.examYear, this.createdAt, this.updatedAt});
//
//   ExamModel.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     gradeId = json["grade_id"];
//     subId = json["sub_id"];
//     examName = json["exam_name"];
//     examYear = json["exam_year"];
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//   }
//
//   static List<ExamModel> fromList(List<dynamic> list) {
//     return list.map((map) => ExamModel.fromJson(map)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["grade_id"] = gradeId;
//     _data["sub_id"] = subId;
//     _data["exam_name"] = examName;
//     _data["exam_year"] = examYear;
//     _data["created_at"] = createdAt;
//     _data["updated_at"] = updatedAt;
//     return _data;
//   }
// }