import 'QP_pending_exam_model.dart';

class CompletedQpExams{
  QpExamsModel? completedExams;
  String? score;
  CompletedQpExams({this.completedExams,this.score});

  CompletedQpExams.fromJson(Map<String, dynamic> json) {
    completedExams = json["exam"] == null ? null : QpExamsModel.fromJson(json["exam"]);
    score = json["score"];
  }
  static List<CompletedQpExams> fromList(List list) {
    return list.map((map) => CompletedQpExams.fromJson(map)).toList();
  }
}