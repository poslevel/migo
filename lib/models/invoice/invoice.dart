import 'package:flutter/cupertino.dart';

class Items {
  String? title;
  int? quantity;
  String? unitPrice;
  String? netAmount;

  Items({this.title, this.quantity, this.unitPrice, this.netAmount});

  Items.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    netAmount = json['net_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['net_amount'] = netAmount;
    return data;
  }
}

class Invoice {
  String? invoiceNumber;
  String? clientName;
  String? clientEmail;
  String? clientNumber;
  String? clientAddress1;
  String? clientAddress2;
  String? clientZipcode;
  String? clientPlace;
  String? clientCountry;
  String? invoiceType;
  int? netAmount;
  List<Items>? items;
  Map<String, dynamic>? itemsDetails;

  Invoice(
      {this.invoiceNumber,
      this.clientName,
      this.clientEmail,
      this.clientNumber,
      this.clientAddress1,
      this.clientAddress2,
      this.clientZipcode,
      this.clientPlace,
      this.clientCountry,
      this.invoiceType,
      this.netAmount,
      this.items});

  Invoice.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    clientName = json['client_name'];
    clientEmail = json['client_email'];
    clientNumber = json['client_number'];
    clientAddress1 = json['client_address1'];
    clientAddress2 = json['client_address2'];
    clientZipcode = json['client_zipcode'];
    clientPlace = json['client_place'];
    clientCountry = json['client_country'];
    invoiceType = json['invoice_type'];
    netAmount = json['net_amount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_number'] = invoiceNumber;
    data['client_name'] = clientName;
    data['client_email'] = clientEmail;
    data['client_number'] = clientNumber;
    data['client_address1'] = clientAddress1;
    data['client_address2'] = clientAddress2;
    data['client_zipcode'] = clientZipcode;
    data['client_place'] = clientPlace;
    data['client_country'] = clientCountry;
    data['invoice_type'] = invoiceType;
    data['net_amount'] = netAmount;
    if (itemsDetails != null) {
      data['items'] = itemsDetails;
    }
    return data;
  }
}

class InvoiceCreation {
  String? clientName;
  String? clientEmail;
  String? clientNumber;
  String? clientAddress1;
  String? clientAddress2;
  String? clientZipcode;
  String? clientPlace;
  String? clientCountry;
  String? invoiceType;
  int? netAmount;
  List<Items>? items;

  InvoiceCreation(
      {this.clientName,
      this.clientEmail,
      this.clientNumber,
      this.clientAddress1,
      this.clientAddress2,
      this.clientZipcode,
      this.clientPlace,
      this.clientCountry,
      this.invoiceType,
      this.netAmount,
      this.items});

  InvoiceCreation.fromJson(Map<String, dynamic> json) {
    clientName = json['client_name'];
    clientEmail = json['client_email'];
    clientNumber = json['client_number'];
    clientAddress1 = json['client_address1'];
    clientAddress2 = json['client_address2'];
    clientZipcode = json['client_zipcode'];
    clientPlace = json['client_place'];
    clientCountry = json['client_country'];
    invoiceType = json['invoice_type'];
    netAmount = json['net_amount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_name'] = clientName;
    data['client_email'] = clientEmail;
    data['client_number'] = clientNumber;
    data['client_address1'] = clientAddress1;
    data['client_address2'] = clientAddress2;
    data['client_zipcode'] = clientZipcode;
    data['client_place'] = clientPlace;
    data['client_country'] = clientCountry;
    data['invoice_type'] = invoiceType;
    data['net_amount'] = netAmount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceApiHandler {
  int? count;
  dynamic next;
  int? previous;
  List<Invoice>? results;

  InvoiceApiHandler({this.count, this.next, this.previous, this.results});

  InvoiceApiHandler.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    // debugPrint("🎅🎅" + json['next']);
    // if (json['next'] is int) {
    //   debugPrint("👼👼👼json['next'] is int");
    // }
    // if (json['next'] is String) {
    //   debugPrint("👼👼👼 json['next'] is String");
    // }
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Invoice>[];
      json['results'].forEach((v) {
        results!.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Invoice>? getInvoice() {
    return results;
  }
}
