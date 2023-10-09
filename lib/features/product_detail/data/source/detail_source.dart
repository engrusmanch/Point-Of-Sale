import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/init_isar.dart';

abstract class ProductDetailDataSource{
  Future<Product> getProductDetail(int id);

}
class ProductDetailDataSourceImpl implements ProductDetailDataSource{
  @override
  Future<Product> getProductDetail(int id)async {
    print("Id:===>$id");
    final isar = IsarSingleton.isar;
    final existingProduct = await isar.products.get(id);
    return existingProduct!;
  }

}