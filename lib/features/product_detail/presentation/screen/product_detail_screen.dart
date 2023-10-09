import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/utils/utils.dart';
import 'package:point_of_sale/features/product_detail/presentation/controller/product_detail_controller.dart';
import 'package:point_of_sale/features/product_detail/presentation/widgets/bar_chart.dart';
import 'package:point_of_sale/features/product_detail/presentation/widgets/slider_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(detailRepo: Get.find(), id: id),
        builder: (detailController) {
          return Scaffold(
            appBar: AppBar(
              title: Text(detailController.product.name ?? ""),
            ),
            body: (detailController.isDetailLoaded)
                ? ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      SizedBox(height: 12),
                      SliderWidget(imgList: detailController.product.images!),
                      SizedBox(height: 12),
                      Text(
                        detailController.product.description ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 12),
                      Text(
                        detailController.product.price.toString().priceLabel,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 120),
                      AspectRatio(
                        aspectRatio: 5,
                        child: CustomBarChart(
                            availableQty:
                                detailController.product.availableQty!,
                            soldQty: detailController.product.soldQty!),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }
}
