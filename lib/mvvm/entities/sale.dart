import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/mvvm/entities/customer.dart';

class Sale {
  String? id;
  DateTime? date;
  List<Product>? products;
  double? totalAmount;
  String? cashier;
  String? paymentMethod;
  Customer? customer;
  String? receiptDetails;

  Sale({
    this.id,
    this.date,
    this.products,
    this.totalAmount,
    this.cashier,
    this.paymentMethod,
    this.customer,
    this.receiptDetails,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    List<dynamic> productData = json['products'];
    List<Product> productList = productData.map((productJson) => Product.fromJson(productJson)).toList();

    return Sale(
      id: json['id'],
      date: DateTime.parse(json['date']),
      products: productList,
      totalAmount: json['total_amount'].toDouble(),
      cashier: json['cashier'],
      paymentMethod: json['payment_method'],
      customer: Customer.fromJson(json['customer']),
      receiptDetails: json['receipt_details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'products': products!.map((product) => product.toJson()).toList(),
      'total_amount': totalAmount,
      'cashier': cashier,
      'payment_method': paymentMethod,
      'customer': customer!.toJson(),
      'receipt_details': receiptDetails,
    };
  }
}
