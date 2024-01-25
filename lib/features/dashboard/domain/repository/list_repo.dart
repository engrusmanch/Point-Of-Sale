import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

abstract class ProductListRepo{
  Future<List<Product>>  getProductsList();
  Future<List<Product>> getSearchedProducts(String searchQuery);
  Future<Product?> getScannedProduct({String? barCode});
}