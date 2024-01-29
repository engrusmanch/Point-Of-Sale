import 'package:equatable/equatable.dart';

class Category extends Equatable {
  int? id;
  String? category;

  Category({this.id, this.category});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      category: json['category'] as String?,
    );
  }
  Category.empty()
  {
    id=null;
    category="";

  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    category,
  ];

  @override
  String toString() => category!;
}