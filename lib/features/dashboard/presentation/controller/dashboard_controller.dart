import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/domain/repository/list_repo.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/generic_scanner.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashboardController extends GetxController {
  final filterFormKey = GlobalKey<FormState>();
  final ProductListRepo prodRepo;
  DashboardController({required this.prodRepo});
  List<Product> productList = [];
  List<Map<String, dynamic>> images = [];
  LoadingState listLoadingState = LoadingState.loading;
  setTempFilterBarCode(newCode) {
    tempFilterBarCode = newCode;
  }

  Product? scannedProduct;

  Future<Product?> searchEntity(String barcode) async {
    try {
      return await prodRepo.getScannedProduct(barCode: barcode).then((value) {
        scannedProduct = value;
        return scannedProduct;
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  scanIfInvalid(BuildContext context) {
    // final CodeScannerController<Product?> stockInScannerController =
    // Get.find<CodeScannerController<Product?>>();
    // stockInScannerController.resumeCamera();
    Navigator.pop(context);
  }

  String searchString = "";
  bool filtersApplied = false;
  applyFilters(BuildContext context) async {
    filtersApplied = true;
    await searchProduct();
    if (context.mounted) {
      Navigator.pop(context);
    }

    update();
  }

  resetFilters(BuildContext context) async {
    filtersApplied = false;
    category = Category.empty();
    searchString = "";
    brand = Brand.empty();
    await searchProduct();
    Navigator.pop(context);
    update();
  }

  setTempFilterSearchString(newSearchString) {
    searchString = newSearchString ?? "";
  }

  scanIfValid(BuildContext context, scannedProduct) async {
    searchString = scannedProduct.name;
    category = scannedProduct.category;
    brand = scannedProduct.supplier;
    try {
      applyFilters(context);
      // final CodeScannerController<Product?> stockInScannerController =
      // Get.find<CodeScannerController<Product?>>();
      // stockInScannerController.resumeCamera();
    } catch (error) {
      Future.error(error);
    }
  }

  updateProduct() {
    update();
  }

  List<Category> categoryModel=[];
  List<Brand> brandModel=[];
  List<String?>? categories;
  List<String?>? brands;
  Category category = Category.empty();
  Brand brand = Brand.empty();
  setCategory(newCategory) {
    category = newCategory ?? Category.empty();
  }

  setBrand(newBrand) {
    brand = newBrand ?? Brand.empty();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    listLoadingState = LoadingState.loading;
    update();
    await prodRepo.getCategories().then((list) {
      categoryModel = list;
      print('Categories list$categoryModel');
      categories=categoryModel.map((e) => e.category).toList();
    });
    await prodRepo.getProductsList().then((list) {
      productList = list;
    });
    await prodRepo.getBrands().then((list) {
      brandModel = list;
      print('Brands list$brandModel');
      brands=brandModel.map((e) => e.brand).toList();
    });
    listLoadingState = LoadingState.loaded;
    update();
  }
  getProductsList()async{
    listLoadingState = LoadingState.loading;
    update();
    await prodRepo.getProductsList().then((list) {
      productList = list;
    });
    listLoadingState = LoadingState.loaded;
    update();
  }

  searchProduct({String? query}) async {
    listLoadingState = LoadingState.loading;
    update();
    if (query != null) {
      await prodRepo
          .getSearchedProducts(
              searchQuery: query, category: category.category!, brand: brand.brand!)
          .then((searchedProducts) {
        productList = searchedProducts;
      });
    } else {
      await prodRepo
          .getSearchedProducts(
              searchQuery: searchString, category: category.category!, brand: brand.brand!)
          .then((searchedProducts) {
        productList = searchedProducts;
      });
    }

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

  // Product? scannedProduct;
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
