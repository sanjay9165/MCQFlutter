class PaymentDetails {
  bool? success;
  Response? response;
  String? userEmail;
  String? userMobile;

  PaymentDetails({this.success, this.response, this.userEmail, this.userMobile});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    response = json["response"] == null ? null : Response.fromJson(json["response"]);
    userEmail = json["user_email"];
    userMobile = json["user_mobile"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if(response != null) {
      data["response"] = response?.toJson();
    }
    data["user_email"] = userEmail;
    data["user_mobile"] = userMobile;
    return data;
  }
}

class Response {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  dynamic offerId;
  String? status;
  int? attempts;
  List<dynamic>? notes;
  int? createdAt;

  Response({this.id, this.entity, this.amount, this.amountPaid, this.amountDue, this.currency, this.receipt, this.offerId, this.status, this.attempts, this.notes, this.createdAt});

  Response.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    entity = json["entity"];
    amount = json["amount"];
    amountPaid = json["amount_paid"];
    amountDue = json["amount_due"];
    currency = json["currency"];
    receipt = json["receipt"];
    offerId = json["offer_id"];
    status = json["status"];
    attempts = json["attempts"];
    notes = json["notes"] ?? [];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["entity"] = entity;
    data["amount"] = amount;
    data["amount_paid"] = amountPaid;
    data["amount_due"] = amountDue;
    data["currency"] = currency;
    data["receipt"] = receipt;
    data["offer_id"] = offerId;
    data["status"] = status;
    data["attempts"] = attempts;
    if(notes != null) {
      data["notes"] = notes;
    }
    data["created_at"] = createdAt;
    return data;
  }
}