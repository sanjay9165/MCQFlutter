
import 'mcq_model.dart';

class ReviewModel {
  int? id;
  int? userId;
  int? gradeId;
  int? subId;
  int? chapId;
  int? questionId;
  String? response;
  int? isCorrect;
  String? createdAt;
  String? updatedAt;
  McqModel? question;

  ReviewModel({this.id, this.userId, this.gradeId, this.subId, this.chapId, this.questionId, this.response, this.isCorrect, this.createdAt, this.updatedAt, this.question});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    gradeId = json["grade_id"];
    subId = json["sub_id"];
    chapId = json["chap_id"];
    questionId = json["question_id"];
    response = json["response"];
    isCorrect = json["is_correct"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    question = json["question"] == null ? null : McqModel.fromJson(json["question"]);
  }
  static List<ReviewModel> fromList(List  list) {
    return list.map((map) => ReviewModel.fromJson(map)).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["grade_id"] = gradeId;
    data["sub_id"] = subId;
    data["chap_id"] = chapId;
    data["question_id"] = questionId;
    data["response"] = response;
    data["is_correct"] = isCorrect;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(question != null) {
      data["question"] = question?.toJson();
    }
    return data;
  }
}
