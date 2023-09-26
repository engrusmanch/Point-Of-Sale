import 'package:point_of_sale/mvvm/entities/sale.dart';

class Customer {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  int? loyaltyPoints;
  List<Sale>? purchaseHistory;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.loyaltyPoints,
    this.purchaseHistory,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      loyaltyPoints: json['loyalty_points'],
      purchaseHistory: List<Sale>.from(json['purchase_history'].map((x) => Sale.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'loyalty_points': loyaltyPoints,
      'purchase_history': List<dynamic>.from(purchaseHistory!.map((x) => x.toJson())),
    };
  }
}
