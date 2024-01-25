import 'package:get/get.dart';
import 'package:point_of_sale/features/add_edit_product/data/repo/repo_impl.dart';
import 'package:point_of_sale/features/add_edit_product/data/source/data_source.dart';
import 'package:point_of_sale/features/add_edit_product/domain/repo/repo.dart';
import 'package:point_of_sale/mvvm/repos/image_repo.dart';
import 'package:point_of_sale/mvvm/sources/image_source.dart';

initAddEditProduct(){
  Get.lazyPut<AddUpdateProductRepo>(
          () => AddUpdateProductRepoImpl(
        remoteSource: Get.find(),
      ),
      fenix: true);
  Get.lazyPut<AddUpdateProductSource>(() => AddUpdateProductSourceImpl(),
      fenix: true);
       Get.lazyPut<ImageRepo>(
          () => ImageRepoImpl(
       remoteDataSource: Get.find()
      ),
      fenix: true);
  Get.lazyPut<ImageRemoteDataSource>(() => ImageRemoteDataSourceImpl(),
      fenix: true);
}