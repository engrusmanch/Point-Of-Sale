import 'dart:typed_data';

import 'package:point_of_sale/core/error/error.dart';
import 'package:point_of_sale/mvvm/sources/image_source.dart';


abstract class ImageRepo {
  Future<Uint8List> getImageBytes(int imageId);
}

class ImageRepoImpl implements ImageRepo {
  final ImageRemoteDataSource remoteDataSource;


  ImageRepoImpl({required this.remoteDataSource});

  @override
  Future<Uint8List> getImageBytes(int imageId) async {

    try {
      return await remoteDataSource.getImageBytes(imageId);
    } on GeneralError catch (error) {
      return Future.error(error);
    } catch (exception, stackTrace) {
      return Future.error(GeneralError(
          message: exception.toString(), stackTrace: stackTrace.toString()));
    }
  }
}
