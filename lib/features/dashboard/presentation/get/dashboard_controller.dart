import 'package:get/get.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';

class DashboardController extends GetxController{
  final ProductListRepo prodRepo;
  DashboardController({required this.prodRepo});
   List<Product>  productList=[];
   LoadingState listLoadingState=LoadingState.loading;
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    listLoadingState=LoadingState.loading;
    update();
    await prodRepo.getProductsList().then((list) {
      productList=list;
    });
    listLoadingState=LoadingState.loaded;
    update();
  }
}