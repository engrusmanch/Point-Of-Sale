
import 'package:point_of_sale/features/dashboard/data_source/source/list_source.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';

class ProductListRepoImpl implements ProductListRepo {
  final ProductListDataSource remoteDataSource;
  ProductListRepoImpl({required this.remoteDataSource});
  @override
  Future<List<Product>> getProductsList() async {
    return await remoteDataSource.getProductsList();
  }

  @override
  Future<List<Product>> getSearchedProducts(
      {required String searchQuery, required String category,required String brand}) async {
    return await remoteDataSource.getSearchedProducts(
        searchQuery: searchQuery, category: category, brand: brand);
  }

  @override
  Future<Product?> getScannedProduct({String? barCode}) async {
    return await remoteDataSource.getScannedProduct(barCode: barCode);
  }

  @override
  Future<List<Brand>> getBrands() async {
    return await remoteDataSource.getBrands();
  }

  @override
  Future<List<Category>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}
