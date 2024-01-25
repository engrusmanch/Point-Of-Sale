import 'package:point_of_sale/features/add_edit_product/data/source/data_source.dart';
import 'package:point_of_sale/features/add_edit_product/domain/repo/repo.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';

class AddUpdateProductRepoImpl implements AddUpdateProductRepo {
  final AddUpdateProductSource remoteSource;
  AddUpdateProductRepoImpl({required this.remoteSource});
  @override
  Future<Product> addProduct(Product newProduct)async {
    return await remoteSource.addProduct(newProduct);
  }

  @override
  Future<Product> updateProduct(Product updatedProduct)async {
   return await remoteSource.updateProduct(updatedProduct);
  }

  @override
  Future<Product?> getDetails(int id) async {
    return await remoteSource.getDetails(id);
  }

  @override
  Future<bool> deleteProduct(int id) async{
    // // TODO: implement deleteProduct
    // throw UnimplementedError();
    return await remoteSource.deleteProduct(id);
  }
}
