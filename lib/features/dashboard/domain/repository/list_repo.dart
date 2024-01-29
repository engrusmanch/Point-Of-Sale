import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';

abstract class ProductListRepo{
  Future<List<Product>>  getProductsList();
  Future<List<Product>> getSearchedProducts({required String searchQuery,required String category,required String brand});
  Future<Product?> getScannedProduct({String? barCode});
  Future<List<Category>> getCategories();
  Future<List<Brand>> getBrands();
}