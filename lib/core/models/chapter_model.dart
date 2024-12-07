

class ChaptersModel {
  int? id;
  int? gradeId;
  int? subId;
  String? name;
  int? chapNo;
  int ? isLocked;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

  ChaptersModel({this.id, this.gradeId, this.subId, this.name,
    this.chapNo, this.createdAt, this.updatedAt,this.subject,this.isLocked});

  ChaptersModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    subId = json["sub_id"];
    name = json["name"];
    chapNo = json["chap_no"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    subject = json["subject"] == null ? null : Subject.fromJson(json["subject"]);
    isLocked=json['is_locked'];
  }

  static List<ChaptersModel> fromList(List<dynamic> list) {
    return list.map((map) => ChaptersModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["grade_id"] = gradeId;
    data["sub_id"] = subId;
    data["name"] = name;
    data["chap_no"] = chapNo;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data['is_locked']=isLocked;
    if(subject != null) {
      data["subject"] = subject?.toJson();
    }
    return data;
  }
}


class Subject {
  int? id;
  int? gradeId;
  String? name;
  String? color;
  String? image;
  String? createdAt;
  String? updatedAt;

  Subject({this.id, this.gradeId, this.name, this.color, this.image, this.createdAt, this.updatedAt});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    name = json["name"];
    color = json["color"];
    image = json["image"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<Subject> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Subject.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["grade_id"] = gradeId;
    data["name"] = name;
    data["color"] = color;
    data["image"] = image;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
