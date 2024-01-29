import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  int? id;
  String? brand;

  Brand({this.id, this.brand});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as int?,
      brand: json['brand'] as String?,
    );
  }
Brand.empty(){
    id=null;
    brand="";
}
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    brand
  ];
  @override
  String toString() => brand!;
}