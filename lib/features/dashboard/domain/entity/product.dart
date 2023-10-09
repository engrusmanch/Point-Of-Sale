import 'package:isar/isar.dart';
part 'product.g.dart';
@collection
class Product {
  Id id=Isar.autoIncrement;
  late String name;
  String? description;
  String? category;
  double? price;
  double? tax;
  double? soldQty;
  double? availableQty;
  String? supplier;
  String? barcode;
  List<String>? images;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get titleWords => name.split(' ');

  Product({
    required this.id,
    required this.name,
    this.description,
    this.category,
    this.price,
    this.tax,
    this.supplier,
    this.barcode,
    this.images,
    this.availableQty,
    this.soldQty
  });
  // Empty constructor
  Product.empty() {
    name = "";
    description = null;
    category = null;
    price = null;
    tax = null;
    supplier = null;
    barcode = null;
    images = null;
    availableQty = null;
    soldQty = null;
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      tax: json['tax'].toDouble(),
      supplier: json['supplier'],
      barcode: json['barcode'],
      images: List<String>.from(json['images']),
      soldQty: json['sold_qty'],
      availableQty: json['available_qty']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'tax': tax,
      'supplier': supplier,
      'barcode': barcode,
      'images': images,
      'available_qty':availableQty,
      'sold_qty':soldQty
    };
  }
}
