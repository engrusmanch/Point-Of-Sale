import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/core/error/error.dart';
import 'package:point_of_sale/core/services/file_service/file_service.dart';
import 'package:point_of_sale/core/services/image_service/image_service.dart';
import 'package:point_of_sale/core/utils/utils.dart';
import 'package:point_of_sale/features/add_edit_product/domain/repo/repo.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/generic_scanner.dart';
import 'package:point_of_sale/main.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';
import 'package:point_of_sale/mvvm/entities/image_data.dart';
import 'package:point_of_sale/mvvm/repos/image_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddUpdateProductController extends GetxController {
  /* <------------------------------ Add/Update Product - Start ------------------------------> */
  final DashboardController _dashboardController =
      Get.find<DashboardController>();
  final FileService _fileService = FileServiceImpl();
  final ImageService _imageService = ImageServiceImpl();
  LoadingState productLoadingState = LoadingState.loading;
  CustomError? customError;
  final int? index;
  final AddUpdateProductRepo addUpdateRepo;
  final ImageRepo imageRepo;
  AddUpdateProductController({
    required this.addUpdateRepo,
    required this.imageRepo,
    // this.productType,
    this.index,
    required this.productOpType,
    // this.productCategory,
  });
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (productOpType == OperationType.edit) {
      selectProduct(index!);
    }
  }

  int? maxQty;
  setQtyMax(newMaxQty) {
    maxQty = int.parse(newMaxQty);
  }

  int? minQty;
  setQtyMin(newMinQty) {
    minQty = int.parse(newMinQty);
  }

  LoadingState deleteLoadingState = LoadingState.loaded;
  bool get isDeleting => deleteLoadingState == LoadingState.loading;

  deleteProduct(int index, BuildContext context) async {
    deleteLoadingState = LoadingState.loading;
    if (imageReference != null) {
      print('delete reference $imageReference');
      await client!.from('product_images').remove([imageReference!]);
    }
    await addUpdateRepo.deleteProduct(idSelectedProduct!).then((value) {
      if (value) {
        listController.productList.removeAt(index);
        listController.updateProduct();
        deleteLoadingState = LoadingState.loaded;
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
  }

  bool get isProductLoading => productLoadingState == LoadingState.loading;

  LoadingState createOrUpdateProductLoadingState = LoadingState.loaded;

  bool get isCreatingOrUpdating =>
      createOrUpdateProductLoadingState == LoadingState.loading;
  DashboardController listController = Get.find();
  //
  // /// Temporary Patch
  // bool get canNotBeUpdated =>
  //     isProductSelected &&
  //     productType != AppLiterals.types[2] &&
  //     qtyMin != 0 &&
  //     qtyMax != 0;

  final productFormKey = GlobalKey<FormState>();

  OperationType productOpType = OperationType.add;
  bool get isProductOpTypeAdd => productOpType == OperationType.add;
  void setProductOpType(OperationType newOperationType) {
    productOpType = newOperationType;
  }

  String get productsPageTitle =>
      isProductOpTypeAdd ? addProductTitle : editProductTitle;

  // String get productsButtonText => isProductOpTypeAdd
  //     ? AppLiterals.addProductButtonText
  //     : AppLiterals.editProductButtonText;

  Product? selectedEntity = Product.empty();

  int? indexSelectedProduct;
  int? idSelectedProduct;

  bool get isProductSelected => idSelectedProduct != null;

  String? productName;
  Category category = Category.empty();
  Brand brand = Brand.empty();
  int? brandId;
  int? categoryId;
  setCategory(newCategory) {
    category = newCategory ?? Category.empty();
    print('category $category');
    // listController.setCategory(category);
    // categoryId = listController.categoryModel
    //     .firstWhereOrNull((element) => element.category == category)
    //     ?.id;
  }

  setBrand(newBrand) {
    brand = newBrand ?? Brand.empty();
    // listController.setBrand(brand);
    // brandId = listController.brandModel
    //     .firstWhereOrNull((element) => element.brand == brand)
    //     ?.id;
  }

  // String? productDescription;
  // setDescription(newDescription){
  //   productDescription=newDescription.toString();
  // }
  String? barCode;
  double? costPrice;
  double? salePrice;
  // ProductCategory? productCategory;
  // ProductType? productType;
  // List<Tax>? vendorTaxes;
  // List<Tax>? customerTaxes;
  // UnitOfMeasure? productUom;
  int? qtyMin;
  int? qtyMax;
  double? availableQty;
  double? soldQty;
  setAvailableQty(newAvailableQty) {
    availableQty = double.parse(newAvailableQty);
  }

  setSoldQty(newSoldQty) {
    soldQty = double.parse(newSoldQty);
  }

  double? saleTax;
  setSaleTax(newSaleTax) {
    saleTax = double.parse(newSaleTax);
  }

  CustomImageData image = CustomImageData();

  // List<Tax> get customerTaxesList => _dashboardController.customerTaxes;
  // List<Tax> get vendorTaxesList => _dashboardController.vendorTaxes;

  /// Setter for [productName], parses and assigns [newName]
  /// value to [productName]
  setProductName(String newName) {
    productName = newName;
    // setQtyReserved();
  }

  ///Function to search the Product through bar code scanner
  Future<Product> searchProduct(String searchBarCode) async {
    final searched =
        await _dashboardController.searchProduct(query: searchBarCode);
    return searched;
  }

  ///Function to check the validity of product
  scanIfValid(BuildContext context, newBarCode) {
    barCode = newBarCode.code;
    print('Barcode $barCode');

    update();
    Navigator.pop(context);
    final CodeScannerController productScannerController =
        Get.find<CodeScannerController>();
    productScannerController.resumeCamera();
  }

  setCostPriceInventory(String newCostPrice) {
    costPrice = double.parse(newCostPrice);
  }

  // String get getTaxNameById=>

  setSalePriceInventory(String newSalePrice) {
    salePrice = double.parse(newSalePrice);
  }

  setBarCode(String? newBarCode) {
    barCode = newBarCode;
  }

  /// Setter for [productType], parses and assigns [newProductType]
  /// value to [productType]
  // setProductType(ProductType? newProductType) {
  //   productType = newProductType;
  //   update();
  //   // setQtyReserved();
  // }

  // bool get isProductTypeStorableProduct => productType == AppLiterals.types[2];

  /// Setter for [productCategory], parses and assigns [newProductCategory]
  /// value to [productCategory]
  // setProductCategory(ProductCategory? newProductCategory) {
  //   productCategory = newProductCategory;
  //   // setQtyReserved();
  // }

  /// Setter for [productUom], parses and assigns [newUom]
  /// value to [productUom]
  // setProductUom(UnitOfMeasure? newUom) {
  //   productUom = newUom;
  // }

  /// Setter for [qtyMin], parses and assigns [newQtyMin]
  /// value to [qtyMin]
  // setQtyMin(String newQtyMin) {
  //   qtyMin = int.parse(newQtyMin.numString);
  // }

  /// Setter for [qtyMax], parses and assigns [newQtyMax]
  /// value to [qtyMax]
  // setQtyMax(String newQtyMax) {
  //   qtyMax = int.parse(newQtyMax.numString);
  // }

  removeImage() {
    image = CustomImageData();
    update();
  }

  String? imageUrl;
  String? imageReference;
  Future addImage() async {
    final newImageFile = await _imageService.pickImage();

    if (newImageFile != null) {
      image.file = newImageFile;
      update();
    }
  }

  /// This function is called to store selected [Inventory] data,
  /// so that it is available for editing, as this function is called
  /// when user presses edit button.
  // DashboardController dashboardController=Get.find();
  // List<Product> productsList=[];
  selectProduct(int index) async {
    // productsList=listController.productList;
    productOpType = OperationType.edit;
    indexSelectedProduct = index;
    idSelectedProduct = listController.productList[index].id;

    productLoadingState = LoadingState.loading;
    update();
    imageReference = listController.productList[index].imageReference;
    productName = listController.productList[index].name;
    description = listController.productList[index].description;
    costPrice = listController.productList[index].costPrice;
    salePrice = listController.productList[index].salePrice;
    saleTax = listController.productList[index].tax;
    availableQty = listController.productList[index].availableQty;
    soldQty = listController.productList[index].soldQty;
    imageUrl = listController.productList[index].image;
    category = listController.productList[index].category ?? Category.empty();
    brand = listController.productList[index].supplier ?? Brand.empty();
    barCode = listController.productList[index].barcode;
    productLoadingState = LoadingState.loaded;
    update();
  }

  addOrEditProduct(BuildContext context) async {
    if (!productFormKey.currentState!.validate()) {
      return;
    }
    createOrUpdateProductLoadingState = LoadingState.loading;
    update();

    if (isProductOpTypeAdd) {
      await createInventory(context);
    } else {
      await updateProduct(context);
    }
  }

  // setValuesInVendorTax(List<Tax>? newVendorTax) {
  //   vendorTaxes = newVendorTax;
  // }
  //
  // setValuesInCustomerTax(List<Tax>? newCustomerTax) {
  //   customerTaxes = newCustomerTax;
  // }
  double? tax;
  setTax(double? newTax) {
    tax = newTax;
  }

  String? description;
  setDescription(newDescription) {
    description = newDescription;
  }

  createInventory(BuildContext context) async {
    if (image.file == null) {
      createOrUpdateProductLoadingState = LoadingState.loaded;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Image Error"),
                content: Text(
                    "Product image is required please provide select the image"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              ));
      update();
    }
    if (image.file != null) {
      final bytes = await image.file!.readAsBytes();

      final ext = '${extension(image.file!.path)}';
      print('image extension $ext');
      final imageName = 'images/${DateTime.now().millisecondsSinceEpoch}$ext';
      imageReference = await client!.from('product_images').uploadBinary(
            "$imageName",
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
      imageReference = "$imageName";
      print('upload response : $imageReference');
      // final storageResponse = await client!
      //     .from('product_images')
      //     .upload('images/${DateTime.now().millisecondsSinceEpoch}.png',
      //         newImageFile);

      imageUrl =
          await client!.from('product_images').getPublicUrl("$imageName");
      print('download url : $imageUrl');
    }

    final newProduct = Product(
        name: productName ?? "",
        description: description,
        imageReference: imageReference,
        barcode: barCode,
        costPrice: costPrice,
        salePrice: salePrice,
        tax: saleTax,
        category: category,
        supplier: brand,
        image: imageUrl ?? "",
        availableQty: availableQty,
        soldQty: soldQty,
        categoryId: category.id,
        brandId: brand.id
        // qtyMax: selectedEntity!.qtyMax,
        );

    await addUpdateRepo.addProduct(newProduct).then((value)async {
      // image.url =
      //     '${AppUrls.imageUrl}${ImageType.product.model}${AppUrls.imageIdQuery}$value${AppUrls.productImageFieldQuery}';
      // final createdProduct = newProduct.copyWith(productId: value);
      // listController.productList.add(value);
      //
      // listController.updateProduct();
      // update();
      if (context.mounted) {
        Navigator.pop(context);
        await listController.getProductsList();
      }

      createOrUpdateProductLoadingState = LoadingState.loaded;

      update();
    });

  }

  updateProduct(BuildContext context) async {
    if (image.file != null) {
      final bytes = await image.file!.readAsBytes();

      if (imageReference != null) {
        print("Image Referenece $imageReference");
        final uploadResponse =
            await client!.from('product_images').updateBinary(
                  imageReference!,
                  bytes,
                  fileOptions: const FileOptions(upsert: true),
                );
        print('upload response : $uploadResponse');
      }
    }

    final updatedProduct = Product(
        id: idSelectedProduct,
        name: productName ?? "",
        imageReference: imageReference,
        description: description,
        barcode: barCode,
        costPrice: costPrice,
        salePrice: salePrice,
        tax: saleTax,
        category: category,
        supplier: brand,
        image: imageUrl ?? "",
        availableQty: availableQty,
        soldQty: soldQty,
        categoryId: categoryId,
        brandId: brandId
        // qtyMax: selectedEntity!.qtyMax,
        );

    await addUpdateRepo.updateProduct(updatedProduct).then((value) {
      int index = listController.productList
          .indexWhere((element) => element.id == value.id);

      if (index != -1) {
        listController.productList[index] = value;
      }
      listController.updateProduct();
      update();
      Navigator.pop(context);

      createOrUpdateProductLoadingState = LoadingState.loaded;
      update();
      _fileService.removeAllFiles();
    }).onError<CustomError>((error, stackTrace) {
      // removeAllSnackBars(context);
      logError('Update Inventory', error);
      createOrUpdateProductLoadingState = LoadingState.loaded;
      update();
      // showErrorDialog(context, error);
    });
  }
}

/* <------------------------------ Add/Update Product - Finish ------------------------------> */
