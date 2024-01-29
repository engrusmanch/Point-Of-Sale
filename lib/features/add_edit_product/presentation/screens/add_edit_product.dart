import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/styles/styles.dart';
import 'package:point_of_sale/core/utils/validators.dart';
import 'package:point_of_sale/core/widgets/button.dart';
import 'package:point_of_sale/core/widgets/dropdown.dart';
import 'package:point_of_sale/core/widgets/error_widget.dart';
import 'package:point_of_sale/core/widgets/form_wrap.dart';
import 'package:point_of_sale/core/widgets/image_case.dart';
import 'package:point_of_sale/core/widgets/image_viewer.dart';
import 'package:point_of_sale/core/widgets/labeled_text_field.dart';
import 'package:point_of_sale/core/widgets/loading_tap_detector.dart';
import 'package:point_of_sale/core/widgets/qr_button.dart';
import 'package:point_of_sale/core/widgets/text_field.dart';
import 'package:point_of_sale/features/add_edit_product/presentation/controller/add_update_controller.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/generic_scanner.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';
import 'package:point_of_sale/mvvm/pages/generic_form.dart';

class AddEditProductPage extends StatelessWidget {
  final OperationType opType;
  final int? index;
  const AddEditProductPage({Key? key, this.index, required this.opType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double labelFontSize = textTheme.titleMedium!.fontSize!;
    // double smallFontSize = textTheme.bodySmall!.fontSize!;

    return GetBuilder<AddUpdateProductController>(
        init: AddUpdateProductController(
            addUpdateRepo: Get.find(),
            imageRepo: Get.find(),
            productOpType: opType,
            index: index),
        builder: (addUpdateProductController) {
          return GenericForm(
            margin: EdgeInsets.all(16),
            // onWillPop: addUpdateProductController.on,
            isLoading: addUpdateProductController.isCreatingOrUpdating,
            operationType: addUpdateProductController.productOpType,
            loadingTapType: LoadingTapType.inventory,
            formKey: addUpdateProductController.productFormKey,
            appBar: (context) => AppBar(
              title: Text(addUpdateProductController.productsPageTitle),
              centerTitle: false,
              actions: [
                if(!addUpdateProductController.isProductOpTypeAdd)
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Delete Confirmation"),
                              content: Text(
                                  "Are you sure you want to delete this product?"),
                              actions: [
                                ButtonWidget(
                                  key: UniqueKey(),
                                  text: "Yes, Confirm",
                                  buttonColor: Colors.green,
                                  buttonType: ButtonType.fill,
                                  onPressed: ()async {
                                    await addUpdateProductController.deleteProduct(index!, context);
                                  },

                                  // isLoading:
                                  //     addUpdateProductController.isDeleting,
                                ),
                                ButtonWidget(
                                  key: UniqueKey(),
                                  text: "No, Cancel",
                                  buttonColor: Colors.red,
                                  buttonType: ButtonType.fill,
                                  onPressed: () async=> Navigator.pop(context),

                                ),
                              ],
                            ));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => AddEditProductPage(
                    //           opType: OperationType.edit,
                    //           index: index,
                    //         )));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.error),
                    child: Icon(Icons.delete_outline),
                  ),
                ),
              ],
            ),
            builder: (context) => SizedBox(child: () {
              if (addUpdateProductController.isProductLoading &&
                  !addUpdateProductController.isProductOpTypeAdd) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!addUpdateProductController.isProductLoading &&
                  addUpdateProductController.customError != null) {
                return CustomErrorWidget(
                  customError: addUpdateProductController.customError!,
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        sizeSectionSmallPlaceHolder,
                        Align(
                          child: FormWrap(children: [
                            LabeledTextField(
                              label: titleText,
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                initialValue:
                                    addUpdateProductController.productName,
                                onChanged:
                                    addUpdateProductController.setProductName,
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    const InputDecoration(hintText: titleHint),
                              ),
                            ),
                            LabeledTextField(
                              label: "Description",
                              fontSize: labelFontSize,
                              textField: Container(
                                clipBehavior: Clip.hardEdge,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    initialValue:
                                        addUpdateProductController.description,

                                    // controller: controller,
                                    maxLines:
                                        255, // Allows the text field to expand as needed
                                    decoration: InputDecoration(
                                      hintText: descriptionHint,
                                      border: InputBorder.none,
                                    ),
                                    onChanged: addUpdateProductController
                                        .setDescription,
                                    validator: EmptyFieldValidator.validator,
                                  ),
                                ),
                              ),
                            ),
                            DropDownWidget<Category>(
                              label: "Category",
                             items: addUpdateProductController.listController.categoryModel,
                              onChanged: addUpdateProductController.setCategory,
                              value: addUpdateProductController.category,
                              itemAsString: (Category category) => category.category ?? '',
                            ),
                            DropDownWidget<Brand>(
                              label: "Brand",
                              itemAsString: (Brand brand)=>brand.brand??'',
                              items: addUpdateProductController.listController.brandModel,
                              onChanged: addUpdateProductController.setBrand,
                              value: addUpdateProductController.brand,
                            ),
                            // LabeledTextField(
                            //   label: "Brand",
                            //   fontSize: labelFontSize,
                            //   textField: TextFormField(
                            //     initialValue: addUpdateProductController.brand,
                            //     onChanged: addUpdateProductController.setBrand,
                            //     validator: EmptyFieldValidator.validator,
                            //     textInputAction: TextInputAction.next,
                            //     decoration:
                            //         const InputDecoration(hintText: brandHint),
                            //   ),
                            // ),
                            SizedBox(
                              width: AppStyles.widgetWidth,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: LabeledTextField(
                                      label: scannerText,
                                      fontSize: labelFontSize,
                                      textField: TextFormField(
                                        key: ValueKey(addUpdateProductController.barCode),
                                        initialValue:
                                            addUpdateProductController.barCode,
                                        onChanged: addUpdateProductController
                                            .setBarCode,
                                        validator:
                                            EmptyFieldValidator.validator,
                                        // textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: scannerHintText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  QrIconButton(onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => GenericCodeScanner(
                                                  scannerType: ScannerType
                                                      .barCodeScanner,
                                                  scanBarCode:
                                                      addUpdateProductController
                                                          .scanIfValid,
                                                )));
                                    Get.delete<CodeScannerController>();
                                  }),
                                ],
                              ),
                            ),

                            // DropDownWidget<UnitOfMeasure>(
                            //   label: uomText,
                            //   items: addUpdateProductController.listController.uomsList,
                            //   value: addUpdateProductController.productUom,
                            //   hint: uomDropDownHint,
                            //   onChanged: addUpdateProductController.setProductUom,
                            //   labelFontSize: labelFontSize,
                            //   validate: true,
                            // ),
                            LabeledTextField(
                              label: "Cost Price",
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                key: UniqueKey(),
                                initialValue: addUpdateProductController
                                    .costPrice
                                    ?.toStringAsFixed(2),
                                onChanged: addUpdateProductController
                                    .setCostPriceInventory,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      priceRegExp),
                                ],
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: costPriceHint,
                                ),
                              ),
                            ),
                            LabeledTextField(
                              label: "Sale Price",
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                key: UniqueKey(),
                                initialValue: addUpdateProductController
                                    .salePrice
                                    ?.toStringAsFixed(2),
                                onChanged: addUpdateProductController
                                    .setSalePriceInventory,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      priceRegExp),
                                ],
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: salePriceHint,
                                ),
                              ),
                            ),
                            // DropDownWidgetMulti(
                            //   label: vendorTaxHint,
                            //   hint: vendorTaxHint,
                            //   items: addUpdateProductController.vendorTaxesList,
                            //   value: addUpdateProductController.vendorTaxes,
                            //   onChanged:
                            //       addUpdateProductController.setValuesInVendorTax,
                            // ),
                            // DropDownWidgetMulti(
                            //   items: addUpdateProductController.customerTaxesList,
                            //   label: customerTaxHint,
                            //   hint: customerTaxHint,
                            //   value: addUpdateProductController.customerTaxes,
                            //   onChanged:
                            //       addUpdateProductController.setValuesInCustomerTax,
                            // ),
                            LabeledTextField(
                              label: "Sale Tax",
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                // readOnly: !addUpdateProductController
                                //     .isProductOpTypeAdd,
                                initialValue: addUpdateProductController.saleTax
                                    ?.toStringAsFixed(2),
                                onChanged:
                                    addUpdateProductController.setSaleTax,
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    hintText: minimumQtyHint),
                              ),
                            ),
                            LabeledTextField(
                              label: "Available Qty",
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                // readOnly: !addUpdateProductController
                                //     .isProductOpTypeAdd,
                                initialValue: addUpdateProductController
                                    .availableQty
                                    ?.toStringAsFixed(2),
                                onChanged:
                                    addUpdateProductController.setAvailableQty,
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    hintText: minimumQtyHint),
                              ),
                            ),
                            LabeledTextField(
                              label: "Sold Qty",
                              fontSize: labelFontSize,
                              textField: TextFormField(
                                // readOnly: !addUpdateProductController
                                //     .isProductOpTypeAdd,
                                initialValue: addUpdateProductController.soldQty
                                    ?.toString(),
                                onChanged:
                                    addUpdateProductController.setSoldQty,
                                validator: EmptyFieldValidator.validator,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    hintText: maximumQtyHint),
                              ),
                            ),

                            GetBuilder<AddUpdateProductController>(
                                builder: (inventoryController) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Image",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
                                      child: (inventoryController.image.file ==
                                                  null &&
                                              inventoryController.imageUrl ==
                                                  null)
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                InkWell(
                                                    onTap: inventoryController
                                                        .addImage,
                                                    child:
                                                        const AddImageMessage()),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                sizeFieldMinPlaceHolder,
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        barrierColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .secondary,
                                                        context: context,
                                                        builder: (_) =>
                                                            ImageViewer(
                                                              imageUrl: !inventoryController
                                                                      .isProductOpTypeAdd
                                                                  ? inventoryController
                                                                      .imageUrl
                                                                  : null,
                                                              imageFile: inventoryController
                                                                      .isProductOpTypeAdd
                                                                  ? inventoryController
                                                                      .image
                                                                      .file
                                                                  : null,
                                                            ));
                                                  },
                                                  child: inventoryController
                                                          .image.file == null
                                                      ? Image.network(
                                                          inventoryController
                                                                  .imageUrl!
                                                                  .isEmpty
                                                              ? "https://media.istockphoto.com/id/1324356458/vector/picture-icon-photo-frame-symbol-landscape-sign-photograph-gallery-logo-web-interface-and.jpg?s=612x612&w=0&k=20&c=ZmXO4mSgNDPzDRX-F8OKCfmMqqHpqMV6jiNi00Ye7rE="
                                                              : inventoryController
                                                                  .imageUrl!,
                                                          height: 100.0,
                                                          width: 160.0,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : Image.file(
                                                          inventoryController
                                                              .image.file!,
                                                          height: 100.0,
                                                          width: 160.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                ),
                                                sizeFieldMinPlaceHolder,
                                                ButtonWidget(
                                                    key: UniqueKey(),
                                                    radius: 0.0,
                                                    text: changePhotoButtonText,
                                                    buttonType:
                                                        ButtonType.transparent,
                                                    onPressed:()async=>
                                                        await inventoryController
                                                            .addImage()),
                                              ],
                                            )),
                                ],
                              );
                            }),
                          ]),
                        ),
                        stackGenericFormBottomPlaceHolder,
                      ],
                    ),
                  ),
                ],
              );
            }()),
            persistentFooterButtons: [
              // inventoryController.canNotBeUpdated
              // ? const Text(
              //     'This Product is Incorrectly Configuration, So it Cannot be Edited!',
              //     textAlign: TextAlign.center,
              //   )
              // :
              ButtonWidget(
                // key: UniqueKey(),
                text: addUpdateProductController.productsPageTitle,
                buttonType: ButtonType.fill,
                onPressed: ()async{
                  await addUpdateProductController.addOrEditProduct(context);

                },
                // isLoading: addUpdateProductController.isCreatingOrUpdating,
              ),
              sizePageBottomPlaceHolder,
            ],
          );
        });
  }
}
