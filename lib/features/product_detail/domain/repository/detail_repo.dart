import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

abstract class ProductDetailRepo{
  Future<Product> getProductDetail(int id);
}