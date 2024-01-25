import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

abstract class AddUpdateProductRepo {
  Future<Product> addProduct(Product newProduct);
  Future<Product> updateProduct(Product updatedProduct);
  Future<Product?> getDetails(int id);
  Future<bool> deleteProduct(int id);
}