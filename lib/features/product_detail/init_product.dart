import 'package:get/get.dart';
import 'package:point_of_sale/features/product_detail/data/repository/detail_repo_impl.dart';
import 'package:point_of_sale/features/product_detail/data/source/detail_source.dart';
import 'package:point_of_sale/features/product_detail/domain/repository/detail_repo.dart';

initProduct(){
  Get.lazyPut<ProductDetailRepo>(
          () => ProductDetailRepImpl(remoteDataSource: Get.find()),
      fenix: true);
  Get.lazyPut<ProductDetailDataSource>(() => ProductDetailDataSourceImpl(),
      fenix: true);
}