class Product {
  String? id;
  String? name;
  String? description;
  String? category;
  double? price;
  double? tax;
  String? supplier;
  String? barcode;
  List<String>? images;

  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.tax,
    this.supplier,
    this.barcode,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      tax: json['tax'].toDouble(),
      supplier: json['supplier'],
      barcode: json['barcode'],
      images: List<String>.from(json['images']),
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
    };
  }
}
