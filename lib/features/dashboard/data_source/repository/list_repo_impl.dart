import 'package:point_of_sale/features/dashboard/data_source/source/list_source.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';

class ProductListRepoImpl implements ProductListRepo{
  final ProductListDataSource remoteDataSource;
  ProductListRepoImpl({required this.remoteDataSource});
  @override
  Future<List<Product>> getProductsList() async{
    return await remoteDataSource.getProductsList();
  }

}