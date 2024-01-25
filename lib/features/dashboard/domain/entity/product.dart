import 'package:isar/isar.dart';

@collection
class Product {
  Id? id = Isar.autoIncrement;
  late String name;
  String? description;
  late String image;
  String? category;
  String? imageReference;
  double? costPrice;
  double? salePrice;
  double? tax;
  double? soldQty;
  double? availableQty;
  String? supplier;
  String? barcode;
  List<String>? images;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get titleWords => name.split(' ');
  @Index()
  List<String> get barCode => barcode!.split(' ');

  Product(
      {this.id,
      required this.name,
      required this.image,
      this.description,
      this.imageReference,
      this.category,
      this.costPrice,
      this.salePrice,
      this.tax,
      this.supplier,
      this.barcode,
      this.images,
      this.availableQty,
      this.soldQty});
  // Empty constructor
  Product.empty() {
    name = "";
    image = "";
    imageReference=null;
    description = null;
    category = null;
    costPrice = null;
    salePrice = null;
    tax = null;
    supplier = null;
    barcode = null;
    images = null;
    availableQty = null;
    soldQty = null;
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    final Product product = Product(
        id: json['id'],
        name: json['name'],
        imageReference: json['image_reference'],
        image: json['product_image'],
        description: json['description'],
        category: json['category'],
        costPrice: json['cost_price'].toDouble(),
        salePrice: json['sale_price'].toDouble(),
        tax: json['tax'].toDouble(),
        supplier: json['supplier'],
        barcode: json['barcode'],
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        soldQty: json['sold_qty'].toDouble(),
        availableQty: json['available_qty'].toDouble());
    print("Product===>${product.image}");
    return product;
  }

  Map<String, dynamic> toJson() {
    return {
      'product_image': image,
      'image_reference':imageReference,
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'cost_price': costPrice,
      'sale_price': salePrice,
      'tax': tax,
      'supplier': supplier,
      'barcode': barcode,
      'images': images,
      'available_qty': availableQty,
      'sold_qty': soldQty
    };
  }
}
