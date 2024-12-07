
class PlanDetails {
  List<PlanModel>? plans;
  String? expiryDate;
  String ? expiryDay;
  PlanDetails({this.plans, this.expiryDate,this.expiryDay});

  PlanDetails.fromJson(Map<String, dynamic> json) {
    plans = json["plans"] == null ? null : (json["plans"] as List).map((e) => PlanModel.fromJson(e)).toList();
    expiryDate = json["expiry_date"];
    expiryDay=json['expiry_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(plans != null) {
      data["plans"] = plans?.map((e) => e.toJson()).toList();
    }
    data["expiry_date"] = expiryDate;
    return data;
  }
}


class PlanModel {
  int? id;
  String? title;
  String? subTitle;
  int? isFree;
  String? price;
  String? discountedPrice;
  String? createdAt;
  String? updatedAt;

  PlanModel({this.id, this.title, this.subTitle, this.isFree, this.price, this.discountedPrice, this.createdAt, this.updatedAt});

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["sub_title"];
    isFree = double.parse(json["discounted_price"].toString())<=0?1:0;
    price = json["price"];
    discountedPrice = json["discounted_price"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<PlanModel> fromList(List<dynamic> list) {
    return list.map((map) => PlanModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["sub_title"] = subTitle;
    data["is_free"] = isFree;
    data["price"] = price;
    data["discounted_price"] = discountedPrice;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}