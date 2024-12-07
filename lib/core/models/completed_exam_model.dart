
import 'package:mcq/core/models/subject_model.dart';

class CompletedExamsModel {
  String? message;
  dynamic subject;
  List<CompletedExams>? completedExams;

  CompletedExamsModel({this.message, this.subject, this.completedExams});

  CompletedExamsModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    subject = json["subject"];
    completedExams = json["completedExams"] == null ? null : (json["completedExams"] as
    List).map((e) => CompletedExams.fromJson(e)).toList();
  }

  static List<CompletedExamsModel> fromList(List<dynamic> list) {
    return list.map((map) => CompletedExamsModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["subject"] = subject;
    if(completedExams != null) {
      data["completedExams"] = completedExams?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class CompletedExams {
  Exam? exam;
  String? score;

  CompletedExams({this.exam, this.score});

  CompletedExams.fromJson(Map<String, dynamic> json) {
    exam = json["exam"] == null ? null : Exam.fromJson(json["exam"]);
    score = json["score"];
  }

  static List<CompletedExams> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => CompletedExams.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(exam != null) {
      data["exam"] = exam?.toJson();
    }
    data["score"] = score;
    return data;
  }
}



class Exam {
  int? id;
  int? gradeId;
  int? subId;
  String? name;
  int? chapNo;
  String? createdAt;
  String? updatedAt;
  SubjectModel? subject;

  Exam({this.id, this.gradeId, this.subId, this.name, this.chapNo, this.createdAt, this.updatedAt, this.subject});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    subId = json["sub_id"];
    name = json["name"];
    chapNo = json["chap_no"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    subject = json["subject"] == null ? null : SubjectModel.fromJson(json["subject"]);
  }

  static List<Exam> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Exam.fromJson(map)).toList();
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
    if(subject != null) {
      data["subject"] = subject?.toJson();
    }
    return data;
  }
}
