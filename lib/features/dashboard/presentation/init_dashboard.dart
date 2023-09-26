import 'package:get/get.dart';
import 'package:point_of_sale/features/dashboard/data_source/repository/list_repo_impl.dart';
import 'package:point_of_sale/features/dashboard/data_source/source/list_source.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';
import 'package:point_of_sale/features/dashboard/presentation/get/dashboard_controller.dart';

initDashboard()async{
  Get.lazyPut<ProductListRepo>(
          () => ProductListRepoImpl(
          remoteDataSource: Get.find(),
         ),
      fenix: true);
  Get.lazyPut<ProductListDataSource>(() => ProductListDataSourceImpl(),
      fenix: true);
  Get.lazyPut(() => DashboardController(prodRepo: Get.find()), fenix: true);
  // await Get.putAsync(() async {
  //   final instance =
  //   DashboardController(prodRepo: Get.find());
  //   await instance.init();
  //   return instance;
  // }, permanent: true);
}