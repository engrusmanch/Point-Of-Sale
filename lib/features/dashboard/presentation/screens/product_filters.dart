import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/widgets/button.dart';
import 'package:point_of_sale/core/widgets/dropdown.dart';
import 'package:point_of_sale/core/widgets/form_wrap.dart';
import 'package:point_of_sale/core/widgets/loading_tap_detector.dart';
import 'package:point_of_sale/features/dashboard/presentation/builder_ids.dart';
import 'package:point_of_sale/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:point_of_sale/features/dashboard/presentation/widgets/filter_buttons.dart';
import 'package:point_of_sale/mvvm/entities/brand.dart';
import 'package:point_of_sale/mvvm/entities/category.dart';
import 'package:point_of_sale/mvvm/pages/generic_form.dart';

import '../../../../core/styles/styles.dart';

/// Screen that allows to filter [PurchaseOrders] listed on [PurchaseOrdersPage]
/// Uses [CustomFilterChips], [DateSelectorWidget], [DropDownWidget], [ButtonWidget]
///
class ProductFiltersPage extends StatelessWidget {
  const ProductFiltersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double buttonFontSize =
    //     Theme.of(context).textTheme.bodySmall!.fontSize!;

    DashboardController inventoryController = Get.find<DashboardController>();
    return GetBuilder<DashboardController>(
        id: updateInventoryFiltersScreen,
        builder: (inventoryController) {
          return ClassicForm(
            margin: AppStyles.formMargin,
            onWillPop: inventoryController.onFiltersPop,
            isLoading: inventoryController.isApplyingFilters,
            loadingTapType: LoadingTapType.filter,
            formKey: inventoryController.filterFormKey,
            appBar: (context) => AppBar(
              automaticallyImplyLeading: true,
              title: const Text("Filter Products"),
            ),
            children: (context) => [
              FormWrap(children: [
                SizedBox(
                  width: AppStyles.widgetWidth,
                  child: TextFormField(
                    key: UniqueKey(),
                    initialValue: inventoryController.searchString,
                    style: Theme.of(context).textTheme.bodySmall,
                    onChanged: inventoryController.setTempFilterSearchString,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Filter Products By Name",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppStyles.widgetWidth,
                  child: TextFormField(
                    key: UniqueKey(),
                    initialValue: inventoryController.tempFilterBarCode,
                    style: Theme.of(context).textTheme.bodySmall,
                    onChanged: inventoryController.setTempFilterBarCode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Filter Products By Barcode",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                DropDownWidget<Category>(
                  onChanged: inventoryController.setCategory,
                  items: inventoryController.categoryModel,
                  hint: "Select Category",
                  label: "Category",
                  itemAsString: (Category category) => category.category ?? '',
                  value: inventoryController.category,
                ),
                DropDownWidget<Brand>(
                  onChanged: inventoryController.setBrand,
                  items: inventoryController.brandModel,
                  hint: "Select Brand",
                  itemAsString: (Brand brand) => brand.brand ?? '',
                  label: "Brand",
                  value: inventoryController.brand,
                )
                // Field Gap

                // Field Gap
                // Row(
                //   children: [
                //     Flexible(
                //       child: TextFormField(
                //           key: UniqueKey(),
                //           initialValue:
                //               inventoryController.tempFilterBarCode,
                //           onChanged:
                //               inventoryController.setFilterBarCode),
                //     ),
                //     InkWell(
                //       child: Container(
                //         height: 48.0,
                //         width: 48.0,
                //         decoration: const BoxDecoration(
                //             border: Border(
                //                 right: BorderSide(
                //                     color: AppColors.primaryColor),
                //                 top: BorderSide(
                //                     color: AppColors.primaryColor),
                //                 bottom: BorderSide(
                //                     color: AppColors.primaryColor))),
                //         padding: const EdgeInsets.all(0.0),
                //         child: const Icon(
                //           AppIcons.iconQrCode,
                //           size: 35.0,
                //         ),
                //       ),
                //       onTap: () async {
                //         await Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (_) => GenericCodeScanner(
                //                       getTag: ScannerControllerTags
                //                           .inventoryFilterScanTag,
                //                       scanBarCode:
                //                           inventoryController.scanBarCode,
                //                   scannerType: ScannerType.barCodeScanner,
                //                     )));
                //         Get.delete<CodeScannerController>(
                //             tag: ScannerControllerTags
                //                 .inventoryFilterScanTag);
                //       },
                //     ),
                //   ],
                // ),
                // AppPlaceHolders.sizeFieldLargePlaceHolder,

                // Container(
                //   alignment: Alignment.centerLeft,
                //   child: Column(
                //     crossAxisAlignment:
                //         CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         AppLiterals.qtyOfUnitsText,
                //         textAlign: TextAlign.left,
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold),
                //       ),
                //       AppPlaceHolders.sizeFieldMinPlaceHolder,
                //       Obx(
                //         () => CheckboxListTile(
                //           contentPadding: EdgeInsets.zero,
                //           value: inventoryController
                //               .tempFilterMinQtyReached!.value,
                //           onChanged: inventoryController
                //               .setFilterMinQty,
                //           title: const Text(
                //               'Minimum Quantity Reached'),
                //           controlAffinity:
                //               ListTileControlAffinity.leading,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Row(
                //   children: [
                //     Flexible(
                //       child: TextFormField(
                //         key: UniqueKey(
                //             inventoryController.tempFilterSearchString ??
                //                 'qtyMin'),
                //         initialValue: inventoryController
                //             .tempFilterQtyMin.eliminateNull,
                //         style: Theme.of(context).textTheme.bodySmall,
                //         onChanged: inventoryController.setFilterQtyMin,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly
                //         ],
                //         textInputAction: TextInputAction.next,
                //         keyboardType: AppTheme.quantityKeyBoardType,
                //         decoration: const InputDecoration(
                //           hintText: AppLiterals.minimumQtySmallHint,
                //         ),
                //       ),
                //     ),
                //     AppPlaceHolders.sizeHorizontalFieldMediumPlaceHolder,
                //     Flexible(
                //       child: TextFormField(
                //         key: UniqueKey(
                //             inventoryController.tempFilterQtyMax ??
                //                 'qtyMax'),
                //         initialValue: inventoryController
                //             .tempFilterQtyMax.eliminateNull,
                //         style: Theme.of(context).textTheme.bodySmall,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly
                //         ],
                //         onChanged: inventoryController.setFilterQtyMax,
                //         validator: (value) =>
                //             MaxQuantityValidator.validator(
                //                 inventoryController
                //                     .tempFilterQtyMax.eliminateNull,
                //                 inventoryController
                //                     .tempFilterQtyMin.eliminateNull,
                //                 true),
                //         textInputAction: TextInputAction.next,
                //         keyboardType: AppTheme.quantityKeyBoardType,
                //         decoration: const InputDecoration(
                //           hintText: AppLiterals.maximumQtySmallHint,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ]),
              sizeFieldMediumPlaceHolder,
            ],
            formActions: FilterButtons(
                key: UniqueKey(),
                resetFiltersOnPressed: () async {
                  await inventoryController.resetFilters(context);
                },
                applyFiltersOnPressed: () async {
                  await inventoryController.applyFilters(context);
                }
                // isLoading: inventoryController.isApplyingFilters
                ),
          );
        });
  }
}
