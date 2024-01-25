import 'dart:typed_data';



abstract class ImageRemoteDataSource {
  Future<Uint8List> getImageBytes(int imageId);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  ImageRemoteDataSourceImpl();

  @override
  Future<Uint8List> getImageBytes(int imageId) {
    // TODO: implement getImageBytes
    throw UnimplementedError();
  }

  // final Dio _dio;


}
