class Promotion {
  String? id;
  String? name;
  String? type;
  String? applicability;
  double? discountAmount;

  Promotion({
    this.id,
    this.name,
    this.type,
    this.applicability,
    this.discountAmount,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      applicability: json['applicability'],
      discountAmount: json['discount_amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'applicability': applicability,
      'discount_amount': discountAmount,
    };
  }
}
