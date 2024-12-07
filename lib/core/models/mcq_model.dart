
class McqModel {
  dynamic id;
  dynamic gradeId;
  dynamic subId;
  dynamic chapId;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? correct;
  String? description;
  String? color;
  String? userSelected;
  String? createdAt;
  String? updatedAt;

  McqModel({this.id, this.gradeId, this.subId, this.chapId, this.question, this.option1, this.option2, this.option3, this.option4, this.correct, this.color, this.createdAt, this.updatedAt});

  McqModel.fromJson(Map<String, dynamic> json) {
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
    description=json["description"];
    color = json["color"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<McqModel> fromList(List<dynamic> list) {
    return list.map((map) => McqModel.fromJson(map)).toList();
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
    data['description']=description;
    data["color"] = color;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}