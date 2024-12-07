class WalletModel {
  String? message;
  String? balance;
  String? uuid;
  List<Transactions>? transactions;
  String? minAmount;
  WalletModel({this.message, this.balance, this.uuid, this.transactions,this.minAmount});

  WalletModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    balance = json["balance"];
    uuid = json["uuid"];
    transactions = json["transactions"] == null ? null : (json["transactions"] as List).map((e) => Transactions.fromJson(e)).toList();
    minAmount=json["min_amount"];
  }

  static List<WalletModel> fromList(List list) {
    return list.map((map) => WalletModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["balance"] = balance;
    data["uuid"] = uuid;
    if(transactions != null) {
      data["transactions"] = transactions?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  int? id;
  String? payableType;
  int? payableId;
  int? walletId;
  String? type;
  String? amount;
  bool? confirmed;
  Meta? meta;
  String? uuid;
  String? createdAt;
  String? updatedAt;

  Transactions({this.id, this.payableType, this.payableId, this.walletId, this.type, this.amount, this.confirmed, this.meta, this.uuid, this.createdAt, this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    payableType = json["payable_type"];
    payableId = json["payable_id"];
    walletId = json["wallet_id"];
    type = json["type"];
    amount = json["amount"];
    confirmed = json["confirmed"];
    meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    uuid = json["uuid"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<Transactions> fromList(List list) {
    return list.map((map) => Transactions.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["payable_type"] = payableType;
    data["payable_id"] = payableId;
    data["wallet_id"] = walletId;
    data["type"] = type;
    data["amount"] = amount;
    data["confirmed"] = confirmed;
    if(meta != null) {
      data["meta"] = meta?.toJson();
    }
    data["uuid"] = uuid;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

class Meta {
  String? description;

  Meta({this.description});

  Meta.fromJson(Map<String, dynamic> json) {
    description = json["description"];
  }

  static List<Meta> fromList(List list) {
    return list.map((map) => Meta.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"] = description;
    return data;
  }
}