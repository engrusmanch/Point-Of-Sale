import 'dart:developer';

import 'package:point_of_sale/core/error/error.dart';

logError(String title, CustomError error) {
  log("<------------------------------ Inside [$title] ------------------------------>");

  log(error.title, error: error);
  log(error.message ?? '', error: error);

  log(error.stackTrace);
}