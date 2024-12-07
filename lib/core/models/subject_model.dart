
class SubjectModel {
  int? id;
  int? gradeId;
  String? name;
  String? color;
  String? image;
  int? totalChapters;
  int? attemptedChapters;
 dynamic avgScore;



  SubjectModel({this.id, this.gradeId, this.name, this.color, this.image, this.totalChapters, this.attemptedChapters, this.avgScore});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    name = json["name"];
    color = json["color"];
    image = json["image"];
    totalChapters = json["total_chapters"];
    attemptedChapters = json["attempted_chapters"];
    avgScore = json["avg_score"];
  }

  static List<SubjectModel> fromList(List<dynamic> list) {
    return list.map((map) => SubjectModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["grade_id"] = gradeId;
    data["name"] = name;
    data["color"] = color;
    data["image"] = image;
    data["total_chapters"] = totalChapters;
    data["attempted_chapters"] = attemptedChapters;
    data["avg_score"] = avgScore;
    return data;
  }
}