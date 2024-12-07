class BankDetailsModel {
  int? id;
  int? userId;
  dynamic bankName;
 String? accountNumber;
  String? holderName;
  String? ifscCode;
  String? upiId;
  String? createdAt;
  String? updatedAt;

  BankDetailsModel({this.id, this.userId, this.bankName, this.accountNumber, this.holderName, this.ifscCode, this.upiId, this.createdAt, this.updatedAt});

  BankDetailsModel.fromJson(Map json) {
    id = json["id"];
    userId = json["user_id"];
    bankName = json["bank_name"];
    accountNumber = json["account_number"];
    holderName = json["holder_name"];
    ifscCode = json["ifsc_code"];
    upiId = json["upi_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<BankDetailsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => BankDetailsModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["bank_name"] = bankName;
    data["account_number"] = accountNumber;
    data["holder_name"] = holderName;
    data["ifsc_code"] = ifscCode;
    data["upi_id"] = upiId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}