import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

class Inventory {
  String? id;
  Product? product;
  int? quantity;

  Inventory({
    this.id,
    this.product,
    this.quantity,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'quantity': quantity,
    };
  }
}
