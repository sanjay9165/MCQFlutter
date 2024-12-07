
class QpSubjectModel {
  List<QPSubjects>? subjects;

  QpSubjectModel({this.subjects});

  QpSubjectModel.fromJson(Map<String, dynamic> json) {
    subjects = json["subjects"] == null ? null : (json["subjects"] as List).map((e) => QPSubjects.fromJson(e)).toList();
  }

  static List<QpSubjectModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => QpSubjectModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(subjects != null) {
      data["subjects"] = subjects?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class QPSubjects {
  Subject? subject;
  dynamic totalExams;
  dynamic totalAttempts;
  dynamic averageScore;

  QPSubjects({this.subject, this.totalExams, this.totalAttempts, this.averageScore});

  QPSubjects.fromJson(Map<String, dynamic> json) {
    subject = json["subject"] == null ? null : Subject.fromJson(json["subject"]);
    totalExams = json["total_exams"];
    totalAttempts = json["total_attempts"];
    averageScore = json["average_score"];
  }

  static List<QPSubjects> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => QPSubjects.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(subject != null) {
      data["subject"] = subject?.toJson();
    }
    data["total_exams"] = totalExams;
    data["total_attempts"] = totalAttempts;
    data["average_score"] = averageScore;
    return data;
  }
}

class Subject {
  dynamic id;
  dynamic gradeId;
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