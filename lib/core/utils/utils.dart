import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:point_of_sale/core/error/error.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

logError(String title, CustomError error) {
  log("<------------------------------ Inside [$title] ------------------------------>");

  log(error.title, error: error);
  log(error.message ?? '', error: error);

  log(error.stackTrace);
}
QrScannerOverlayShape qrScannerOverlayShape = QrScannerOverlayShape(
  borderColor: Colors.grey[900]!,
  overlayColor: const Color.fromRGBO(0, 0, 0, 80),
  borderRadius: 10,
  borderLength: 30,
  borderWidth: 10,
  cutOutWidth: 300.0,
  cutOutHeight: 200.0,
  cutOutBottomOffset: 150.0,
);

extension price on String {
  String get priceLabel => '${this} PKR';
}