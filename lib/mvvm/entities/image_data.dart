import 'dart:io';

import 'package:flutter/services.dart';

class CustomImageData {
  int? id;
  String? name;
  String? url;
  File? file;
  Uint8List? bytes;

  CustomImageData({this.id, this.name, this.url, this.file, this.bytes});
}
