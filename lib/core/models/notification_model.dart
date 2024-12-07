import 'package:mcq/core/models/mcq_model.dart';
import 'package:mcq/core/models/student_model.dart';

class NotificationModel {
  int? id;
  int? sendUserId;
  dynamic recieveUserId;
  int? reportedQuesId;
  String? message;
  int? status;
  int? ismcq;
  String? createdAt;
  String? updatedAt;
  StudentModel? user;
  ReportedModel? reportedMcqQues;
  McqModel? reportedMcqQuesMcq;
  ReportedModel? reportedQuesPaper;
  McqModel? reportedQuesPaperMcq;

  NotificationModel({this.id, this.sendUserId, this.recieveUserId, this.reportedQuesId, this.message, this.status, this.ismcq, this.createdAt, this.updatedAt, this.user, this.reportedMcqQues, this.reportedMcqQuesMcq, this.reportedQuesPaper, this.reportedQuesPaperMcq});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sendUserId = json["send_user_id"];
    recieveUserId = json["recieve_user_id"];
    reportedQuesId = json["reported_ques_id"];
    message = json["message"];
    status = json["status"];
    ismcq = json["ismcq"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = json["user"] == null ? null : StudentModel.fromJson(json["user"]);
    reportedMcqQues = json["reported_mcq_ques"]==null?null:ReportedModel.fromJson(json["reported_mcq_ques"]);
    reportedMcqQuesMcq = json["reported_mcq_ques_mcq"] == null ? null : McqModel.fromJson(json["reported_mcq_ques_mcq"]);
    reportedQuesPaper = json["reported_ques_paper"]==null?null:ReportedModel.fromJson(json["reported_ques_paper"]);
    reportedQuesPaperMcq = json["reported_ques_paper_mcq"]==null?null:McqModel.fromJson(json["reported_ques_paper_mcq"]);
  }

  static List<NotificationModel> fromList(List list) {
    return list.map((map) => NotificationModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["send_user_id"] = sendUserId;
    data["recieve_user_id"] = recieveUserId;
    data["reported_ques_id"] = reportedQuesId;
    data["message"] = message;
    data["status"] = status;
    data["ismcq"] = ismcq;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(user != null) {
      data["user"] = user?.toJson();
    }
    data["reported_mcq_ques"] = reportedMcqQues;
    if(reportedMcqQuesMcq != null) {
      data["reported_mcq_ques_mcq"] = reportedMcqQuesMcq?.toJson();
    }
    data["reported_ques_paper"] = reportedQuesPaper;
    data["reported_ques_paper_mcq"] = reportedQuesPaperMcq;
    return data;
  }
}

class ReportedMcqQuesMcq {
  int? id;
  int? gradeId;
  int? subId;
  int? chapId;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? correct;
  String? color;
  String? createdAt;
  String? updatedAt;
  String? description;

  ReportedMcqQuesMcq({this.id, this.gradeId, this.subId, this.chapId, this.question, this.option1, this.option2, this.option3, this.option4, this.correct, this.color, this.createdAt, this.updatedAt, this.description});

  ReportedMcqQuesMcq.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    gradeId = json["grade_id"];
    subId = json["sub_id"];
    chapId = json["chap_id"];
    question = json["question"];
    option1 = json["option_1"];
    option2 = json["option_2"];
    option3 = json["option_3"];
    option4 = json["option_4"];
    correct = json["correct"];
    color = json["color"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    description = json["description"];
  }

  static List<ReportedMcqQuesMcq> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ReportedMcqQuesMcq.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["grade_id"] = gradeId;
    data["sub_id"] = subId;
    data["chap_id"] = chapId;
    data["question"] = question;
    data["option_1"] = option1;
    data["option_2"] = option2;
    data["option_3"] = option3;
    data["option_4"] = option4;
    data["correct"] = correct;
    data["color"] = color;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["description"] = description;
    return data;
  }
}
class ReportedModel {
  int? id;
  int? userId;
  int? quesId;
  String? markedAnswer;
  String? correctAnswer;
  String? description;
  dynamic file;
  int? status;
  String? createdAt;
  String? updatedAt;

  ReportedModel({this.id, this.userId, this.quesId, this.markedAnswer, this.correctAnswer, this.description, this.file, this.status, this.createdAt, this.updatedAt});

  ReportedModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    quesId = json["ques_id"];
    markedAnswer = json["marked_answer"];
    correctAnswer = json["correct_answer"];
    description = json["description"];
    file = json["file"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<ReportedModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ReportedModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["ques_id"] = quesId;
    data["marked_answer"] = markedAnswer;
    data["correct_answer"] = correctAnswer;
    data["description"] = description;
    data["file"] = file;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

