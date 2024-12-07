

import 'package:mcq/core/models/subject_model.dart';

import 'chapter_model.dart';

class DashBoardModel {
  String? studentName;
  dynamic studentGender;
  dynamic averageScore;
  dynamic progress;
  List<ChaptersModel>? allChapters;
  List<SubjectModel>? subjectsData;

  DashBoardModel({this.studentName, this.studentGender, this.averageScore, this.progress, this.allChapters, this.subjectsData});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    studentName = json["student_name"];
    studentGender = json["student_gender"];
    averageScore = json["average_score"];
    progress = json["progress"];
    allChapters = json["pending_chapters"] == null ? null : (json["pending_chapters"] as List).map((e) => ChaptersModel.fromJson(e)).toList();
    subjectsData = json["subjects_data"]== null ? null : (json["subjects_data"] as List).map((e) => SubjectModel.fromJson(e)).toList();
  }

  static List<DashBoardModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => DashBoardModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["student_name"] = studentName;
    data["student_gender"] = studentGender;
    data["average_score"] = averageScore;
    data["progress"] = progress;
    if(allChapters != null) {
      data["pending_chapters"] = allChapters?.map((e) => e.toJson()).toList();
    }
    if(subjectsData != null) {
      data["subjects_data"] = subjectsData?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

