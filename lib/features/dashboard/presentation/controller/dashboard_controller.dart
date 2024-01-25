import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashboardController extends GetxController {
  final ProductListRepo prodRepo;
  DashboardController({required this.prodRepo});
  List<Product> productList = [];
  List<Map<String, dynamic>> images = [];
  LoadingState listLoadingState = LoadingState.loading;
  updateProduct(){
    update();
  }
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    listLoadingState = LoadingState.loading;
    update();
    await prodRepo.getProductsList().then((list) {
      productList = list;
    });
    listLoadingState = LoadingState.loaded;
    update();
  }

  searchProduct(String? query) async {
    listLoadingState = LoadingState.loading;
    update();
    await prodRepo.getSearchedProducts(query!).then((searchedProducts) {
      productList = searchedProducts;
    });
    listLoadingState = LoadingState.loaded;
    update();
  }

  String? tempFilterBarCode;
  LoadingState filtersApplyingState = LoadingState.loaded;
  bool get isApplyingFilters => filtersApplyingState == LoadingState.loading;
  scanBarCode(BuildContext context, Barcode barcode) {
    tempFilterBarCode = barcode.code;
    onFiltersPop();
    dynamicFilters(dynamicFilterBarCode: tempFilterBarCode);
    Navigator.pop(context);
  }

  Product? scannedProduct;
  dynamicFilters({String? dynamicFilterBarCode}) async {
    await prodRepo
        .getScannedProduct(barCode: dynamicFilterBarCode)
        .then((scanned) {
      scannedProduct = scanned;
      log("scanned product name===>${scannedProduct!.name}");
      print("scanned product description===>${scannedProduct!.description}");
    });
  }

  Future<bool> onFiltersPop() async {
    if (isApplyingFilters) {
      return false;
    }
    return true;
  }
}
