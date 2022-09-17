// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

import 'package:migo/models/product/product.dart';

class Invoice {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? customerAddress;
  String? date;
  String? totalAmount;
  String? transactionStatus;
  String? paymentMode;
  String? store;
  String? posOperator;
  List<Product>? products;

  Invoice(
      {this.id,
      this.customerName,
      this.customerEmail,
      this.customerPhone,
      this.customerAddress,
      this.date,
      this.totalAmount,
      this.transactionStatus,
      this.paymentMode,
      this.store,
      this.posOperator,
      this.products});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['invoice_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    date = json['date'];
    totalAmount = json['amount'];
    transactionStatus = json['transaction_status'];
    paymentMode = json['payment_mode'];
    store = json['store'];
    posOperator = json['pos_operator'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['date'] = this.date;
    data['amount'] = this.totalAmount;
    data['transaction_status'] = this.transactionStatus;
    data['payment_mode'] = this.paymentMode;
    data['store'] = this.store;
    data['pos_operator'] = this.posOperator;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Product {
//   int? id;
//   String? name;
//   String? description;
//   String? category;
//   String? price;
//   String? sellingPrice;
//   int? stockAmount;
//   int? quantity;

//   Product(
//       {this.id,
//       this.name,
//       this.description,
//       this.category,
//       this.price,
//       this.sellingPrice,
//       this.stockAmount,
//       this.quantity});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     category = json['category'];
//     price = json['price'];
//     sellingPrice = json['selling_price'];
//     stockAmount = json['stock_amount'];
//     quantity = json['quantity'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['price'] = this.price;
//     data['selling_price'] = this.sellingPrice;
//     data['stock_amount'] = this.stockAmount;
//     data['quantity'] = this.quantity;
//     return data;
//   }
// }
