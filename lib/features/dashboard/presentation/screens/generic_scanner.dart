import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/core/error/error.dart';
import 'package:point_of_sale/core/styles/placeholders.dart';
import 'package:point_of_sale/core/utils/utils.dart';
import 'package:point_of_sale/core/widgets/button.dart';
import 'package:point_of_sale/features/dashboard/presentation/builder_ids.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CodeScannerController<T> extends GetxController {
  /// This variable either stores the [ScannedEntity], that is
  /// fetched from the [searchProducts] API which is then used on the [PickProductsPage],
  /// or stores the data of [ScannedEntity],  that is selected for editing
  // ScannedEntity? selectedLine; // Also used in [PickProductsPage]

  T? scannedEntity;

  Barcode? barCode;
  RxInt? countedQuantity = 0.obs;
  double? qtyAvailable;
  String? productName;

  setCountedQuantity(double newCountedQuantity) {
    countedQuantity!.value = newCountedQuantity.round();

    update([updateQRScanner]);
  }

  setProductName(String newName) {
    productName = newName;
  }

  setQtyAvailable(double? newQtyAvailable) {
    qtyAvailable = newQtyAvailable;

    update([updateQRScanner]);
  }

  /// This variable shows if there is a [Entity] against the scanned [barCode]
  /// If this variable is [true], the user is allowed to proceed to the [PickProductsPage],
  /// where the user can add [qtyDemand] and [qtyDone], and then if the user presses
  /// 'Add Product' button, [addOrEditProduct] is called add the [Entity] to the
  /// [lines].
  bool? validated;
  LoadingState validationLoadingState = LoadingState.loaded;

  bool get isValidating => validationLoadingState == LoadingState.loading;

  QRViewController? qrViewController;

  Future<T> Function(String barCode)? searchEntity;

  // Function(BuildContext context, dynamic)? scanIfValid;
  // Function(BuildContext context)? scanIfInValid;
  //
  // Function(BuildContext context, Barcode barCode)? scanBarCode;
  ScannerType scannerType;
  final Function(double newCount)? updateCount;
  final bool Function(T t)? validation;

  CodeScannerController(
      {this.searchEntity,
      this.updateCount,
      this.scannerType = ScannerType.entityScanner,
      this.validation});

  onQrViewCreated(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) async {
      barCode = scanData;

      // Pausing camera once a [barCode] is scanned.
      // User can pressed [Refresh IconButton] on top-right
      // corner of [CodeScannerInternalTransfer] to resume camera,
      // if they want to scan some other [barCode]
      await qrViewController!.pauseCamera();
      if (scannerType != ScannerType.barCodeScanner) {
        validationLoadingState = LoadingState.loading;
        update([updateQRScanner]);

        await searchEntity!(barCode!.code!).then((value) async {
          // Checking if any [Entity] is returned from the [searchProduct] api.
          // If the returned value is not empty, then the [barCode] is valid and the [validated]
          // is set to [true], and the returned value is assigned to [selectedLine]

          if (validation != null) {
            if (validation!(value)) {
              await FlutterBeep.beep();
              validated = true;
              scannedEntity = value;

              if (scannerType == ScannerType.counterScanner) {
                countedQuantity!.value = countedQuantity!.value + 1;
                await Future.delayed(const Duration(milliseconds: 1000));
                resetCodeScanner();
                qrViewController!.resumeCamera();
                updateCount!((countedQuantity!.value.toDouble()));
              }
            } else {
              validated = false;
              await FlutterBeep.beep(false);
            }
          } else {
            validated = true;
            scannedEntity = value;
          }

          // if (value != emptyConstructor) {

          // }
          // If the value is equal to empty [Entity], then the [barCode] is considered invalid and
          // [validated] is set to [false]
          // else {
          //   validated = false;
          // }
        }).onError<CustomError>((error, stackTrace) {
          validated = false;
          logError('Code Scanner', error);
        });
        validationLoadingState = LoadingState.loaded;

        update([updateQRScanner]);
      } else if (scannerType == ScannerType.barCodeScanner) {
        validationLoadingState = LoadingState.loaded;

        update([updateQRScanner]);
      }

      // Rebuilding scanner once BarCode is scanned
    });

    controller.pauseCamera();
    controller.resumeCamera();
  }

  GlobalKey<State<StatefulWidget>> get qrKey => GlobalKey(debugLabel: 'QR');

  resetCodeScanner() async {
    scannedEntity = null;
    barCode = null;
    validated = null;
  }

  Future<bool> onScannerPop() async {
    if (isValidating) {
      return false;
    }
    return true;
  }

  resumeCamera() {
    qrViewController!.resumeCamera();

    // Setting code scanner values to default, so another code can be scanned with the same flow
    resetCodeScanner();
    update([updateQRScanner]);
  }

  counterScanner() async {
    if (scannerType == ScannerType.counterScanner) {
      await Future.delayed(const Duration(milliseconds: 1000));
      qrViewController!.resumeCamera();
      countedQuantity!.value = countedQuantity!.value + 1;
    }
  }
}

enum ScannerType { entityScanner, barCodeScanner, counterScanner }

class GenericCodeScanner<T> extends StatelessWidget {
  const GenericCodeScanner(
      {Key? key,
      this.textScanIfValid = scanValidButtonText,
      this.textScanIfInvalid = scanInvalidButtonText,
      this.searchEntity,
      this.scanIfValid,
      this.scanIfInValid,
      this.scannerType = ScannerType.entityScanner,
      this.validation,
      this.updateCount,
      this.scanBarCode})
      : super(key: key);
  final String textScanIfValid;
  final String textScanIfInvalid;
  final Future<T> Function(String barCode)? searchEntity;
  final Function(BuildContext context, dynamic)? scanIfValid;
  final Function(BuildContext context)? scanIfInValid;
  final Function(BuildContext context, Barcode barCode)? scanBarCode;
  final Function(double newCount)? updateCount;
  final ScannerType scannerType;
  final bool Function(T t)? validation;

  @override
  Widget build(BuildContext context) {
    // final CodeScannerController<T> scannerController = Get.put(
    //     );

    // TODO: Test this
    return GetBuilder<CodeScannerController<T>>(
        init: CodeScannerController<T>(
            searchEntity: searchEntity,
            scannerType: scannerType,
            updateCount: updateCount,
            validation: validation),
        builder: (scannerController) {
          return ConditionalWillPopScope(
            onWillPop: scannerController.onScannerPop,
            shouldAddCallback: scannerController.isValidating,
            child: Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        QRView(
                          // TODO: See if key can be Value key
                          key: scannerController.qrKey,
                          overlay: qrScannerOverlayShape,
                          onQRViewCreated: scannerController.onQrViewCreated,
                        ),
                        Positioned(
                          right: 15.0,
                          top: 40.0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.refresh_outlined,
                              color: Colors.white,
                            ),
                            onPressed: scannerController.resumeCamera,
                          ),
                        ),
                        const Positioned(
                          left: 15.0,
                          top: 40.0,
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          // bottom: 300.0,
                          // width: 300.0,
                          // height: 70.0,
                          alignment: Alignment.center,
                          child: Container(
                            height: 60.0,
                            width: 300.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(14.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                sizeHorizontalFieldSmallPlaceHolder,
                                const Text(
                                  scanGuideText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GetBuilder<CodeScannerController<T>>(
                            id: updateQRScanner,
                            builder: (scannerController) {
                              return Positioned(
                                  bottom: 50.0,
                                  width: 300.0,
                                  height: 152.0,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (scannerType ==
                                          ScannerType.counterScanner) ...[
                                        if (scannerController.validated != null)
                                          // ? SizedBox()
                                          (!scannerController.validated!)
                                              ? const Text(codeInValidText,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : const SizedBox(),

                                        // AppPlaceHolders.sizeFieldMediumPlaceHolder,

                                        if (scannerController.productName !=
                                                null &&
                                            scannerController.qtyAvailable !=
                                                null)
                                          Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (scannerController
                                                        .validated ==
                                                    null)

                                                  // if(scannerController.productName!=null)

                                                  Text(
                                                    'Product Name: ${scannerController.productName}',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                if (scannerController
                                                        .validated ==
                                                    null)

                                                  // if(scannerController.qtyAvailable != null)
                                                  Obx(() {
                                                    return Text(
                                                      '${scannerController.countedQuantity!.value}/${scannerController.qtyAvailable!.round()}',
                                                      style: const TextStyle(
                                                          fontSize: 35,
                                                          color: Colors.white),
                                                    );
                                                  }),
                                                if (scannerController
                                                        .validated ==
                                                    null)

                                                  // if (scannerController.productName != null && scannerController.qtyAvailable != null)
                                                  ButtonWidget(
                                                    text: "Done",
                                                    buttonType: ButtonType.fill,
                                                    onPressed: ()async =>
                                                        Navigator.pop(context),
                                                  ),
                                              ])
                                        // : SizedBox(),
                                        // scannerController.qtyAvailable == null
                                        //     ? SizedBox()
                                        //     : Obx(() {
                                        //         return Text(
                                        //           '${scannerController.countedQuantity!.value}/${scannerController.qtyAvailable}',
                                        //           style: TextStyle(
                                        //               fontSize: 35,
                                        //               color: Colors.white),
                                        //         );
                                        //       }),
                                      ] else if (scannerController.barCode ==
                                          null)
                                        const Text(
                                          codeScanningText,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      else if (scannerController.barCode !=
                                          null)
                                        if (scannerController.validated == null)
                                          if (scannerController.isValidating)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Text(
                                                  codeValidatingText,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                sizeHorizontalFieldMediumPlaceHolder,
                                                const SizedBox(
                                                    height: 20.0,
                                                    width: 20.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            )
                                          else
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                const Text(codeScannedText,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                sizeHorizontalFieldMediumPlaceHolder,
                                                const CircleAvatar(
                                                    radius: 12.0,
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 12.0,
                                                    ))
                                              ],
                                            )
                                        else if (scannerController.validated!)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const Text(codeValidText,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              sizeHorizontalFieldMediumPlaceHolder,
                                              const CircleAvatar(
                                                  radius: 12.0,
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 12.0,
                                                  ))
                                            ],
                                          )
                                        else
                                          const Text(codeInValidText,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                      sizeFieldMediumPlaceHolder,

                                      if (scannerController.barCode == null)
                                        const SizedBox()
                                      else if (scannerController.barCode !=
                                          null)
                                        if (scannerController.validated == null)
                                          if (scannerController.isValidating)
                                            const SizedBox()
                                          else
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ButtonWidget(
                                                    key: UniqueKey(),
                                                      text: readBarCodeButtonText,
                                                      buttonType: ButtonType
                                                          .fill,

                                                      onPressed: ()async =>
                                                         await scanBarCode!(
                                                              context,
                                                              scannerController
                                                                  .barCode!),
                                                  ),
                                                ),
                                              ],
                                            )
                                        else if (scannerController.validated! &&
                                            scannerController.scannerType !=
                                                ScannerType.counterScanner)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ButtonWidget(
                                                  key: UniqueKey(),
                                                    text: textScanIfValid,
                                                    buttonType: ButtonType.fill,
                                                    onPressed: ()async =>
                                                       await scanIfValid!(
                                                            context,
                                                            scannerController
                                                                .scannedEntity)),
                                              ),
                                            ],
                                          )
                                        else if (scannerController
                                                .scannerType !=
                                            ScannerType.counterScanner)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ButtonWidget(
                                                    text: textScanIfInvalid,
                                                    buttonType: ButtonType.fill,
                                                    onPressed: () =>
                                                        scanIfInValid!(
                                                            context)),
                                              ),
                                            ],
                                          ),
                                      // AppPlaceHolders.sizeFieldMediumPlaceHolder,

                                      // scannerController.barCode == null
                                      //     ? const SizedBox()
                                      //     : scannerType ==
                                      //             ScannerType.barCodeScanner
                                      //         ? Row(
                                      //             children: [
                                      //               Expanded(
                                      //                 child: ButtonWidget(
                                      //                     text: AppLiterals
                                      //                         .readBarCodeButtonText,
                                      //                     buttonType:
                                      //                         ButtonType.fill,
                                      //                     onPressed: () =>
                                      //                         scanBarCode!(
                                      //                             context,
                                      //                             scannerController
                                      //                                 .barCode!)),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         : scannerController.validated ==
                                      //                 null
                                      //             ? const SizedBox()
                                      //             : scannerController.validated!
                                      //                 ? Row(
                                      //                     children: [
                                      //                       Expanded(
                                      //                         child: ButtonWidget(
                                      //                             text:
                                      //                                 textScanIfValid,
                                      //                             buttonType:
                                      //                                 ButtonType
                                      //                                     .fill,
                                      //                             onPressed: () =>
                                      //                                 scanIfValid!(
                                      //                                     context,
                                      //                                     scannerController
                                      //                                         .scannedEntity)),
                                      //                       ),
                                      //                     ],
                                      //                   )
                                      //                 : Row(
                                      //                     children: [
                                      //                       Expanded(
                                      //                         child: ButtonWidget(
                                      //                             text:
                                      //                                 textScanIfInvalid,
                                      //                             buttonType:
                                      //                                 ButtonType
                                      //                                     .fill,
                                      //                             onPressed: () =>
                                      //                                 scanIfInValid!(
                                      //                                     context)),
                                      //                       ),
                                      //                     ],
                                      //                   )
                                    ],
                                  ));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
