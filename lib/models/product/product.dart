class Product {
  int? id;
  String? name;
  String? description;
  String? category;
  String? price;
  String? sellingPrice;
  int? stockAmount;
  String? url;
  String? image;
  int? qty;

  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.sellingPrice,
    this.stockAmount,
    this.url,
    this.image,
    this.qty,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    sellingPrice = json['selling_price'];
    stockAmount = json['stock_amount'];
    url = json['url'];
    image = json['image'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['selling_price'] = sellingPrice;
    data['stock_amount'] = stockAmount;
    data['url'] = url;
    data['image'] = image;
    data['qty'] = qty;
    return data;
  }
}

class Keyword {
  String? category;
  String? query;

  Keyword({this.category, this.query});

  Keyword.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['query'] = query;
    return data;
  }
}
