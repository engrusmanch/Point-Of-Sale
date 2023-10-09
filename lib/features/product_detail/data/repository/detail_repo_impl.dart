import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/product_detail/data/source/detail_source.dart';
import 'package:point_of_sale/features/product_detail/domain/repository/detail_repo.dart';

class ProductDetailRepImpl implements ProductDetailRepo{
  final ProductDetailDataSource remoteDataSource;
  ProductDetailRepImpl({required this.remoteDataSource});
  @override
  Future<Product> getProductDetail(int id)async {
    return await remoteDataSource.getProductDetail(id);
  }

}