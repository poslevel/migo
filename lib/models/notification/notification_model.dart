class Notification {
  String? category;
  String? description;
  int? stockAmount;
  int? store;

  Notification({this.category, this.description, this.stockAmount, this.store});

  Notification.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    stockAmount = json['stock_amount'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['description'] = description;
    data['stock_amount'] = stockAmount;
    data['store'] = store;
    return data;
  }
}
