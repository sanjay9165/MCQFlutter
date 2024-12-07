
class StudentModel {
  dynamic id;
  String? name;
  String? email;
  String? phoneNo;
  dynamic emailVerifiedAt;
  String? gender;
  dynamic gradeId;
  dynamic dob;
  String? password;
  String? createdAt;
  String? updatedAt;
  List<Roles>? roles;


  StudentModel({this.id, this.name, this.email, this.phoneNo,
    this.emailVerifiedAt, this.gender, this.gradeId, this.dob,
    this.createdAt, this.updatedAt,this.password, this.roles});

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phoneNo = json["phone_no"];
    emailVerifiedAt = json["email_verified_at"];
    gender = json["gender"];
    gradeId = json["grade_id"];
    dob = json["dob"];
    password = json["password"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    roles = json["roles"] == null ? null : (json["roles"] as List).map((e) => Roles.fromJson(e)).toList();
  }

  static List<StudentModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => StudentModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone_no"] = phoneNo;
    data["email_verified_at"] = emailVerifiedAt;
    data["gender"] = gender;
    data["grade_id"] = gradeId;
    data["dob"] = dob;
    data["password"] = password;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(roles != null) {
      data["roles"] = roles?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  dynamic id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles({this.id, this.name, this.guardName, this.createdAt, this.updatedAt, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    guardName = json["guard_name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    pivot = json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]);
  }

  static List<Roles> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Roles.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["guard_name"] = guardName;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(pivot != null) {
      data["pivot"] = pivot?.toJson();
    }
    return data;
  }
}

class Pivot {
  String? modelType;
  dynamic modelId;
  dynamic roleId;

  Pivot({this.modelType, this.modelId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelType = json["model_type"];
    modelId = json["model_id"];
    roleId = json["role_id"];
  }

  static List<Pivot> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Pivot.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["model_type"] = modelType;
    data["model_id"] = modelId;
    data["role_id"] = roleId;
    return data;
  }
}