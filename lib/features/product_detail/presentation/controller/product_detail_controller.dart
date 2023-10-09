import 'package:get/get.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/product_detail/domain/repository/detail_repo.dart';

class ProductDetailController extends GetxController {
  final ProductDetailRepo detailRepo;
  final int id;
  ProductDetailController({required this.detailRepo, required this.id});
  LoadingState detailLoadingState = LoadingState.loading;
  bool get isDetailLoaded => detailLoadingState == LoadingState.loaded;
  Product product = Product.empty();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    detailLoadingState = LoadingState.loading;
    update();
    await detailRepo.getProductDetail(id).then((newProduct) {
      product = newProduct;
      detailLoadingState = LoadingState.loaded;
      update();
    });
  }
}
