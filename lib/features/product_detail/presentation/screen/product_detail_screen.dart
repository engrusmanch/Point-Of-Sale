import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/utils/utils.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/product_detail/presentation/controller/product_detail_controller.dart';
import 'package:point_of_sale/features/product_detail/presentation/widgets/bar_chart.dart';
import 'package:point_of_sale/features/product_detail/presentation/widgets/slider_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final int id;
  final Product product;
  const ProductDetailScreen(
      {super.key, required this.id, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(detailRepo: Get.find(), id: id),
        builder: (detailController) {
          return Scaffold(
              appBar: AppBar(
                title: Text(product.name ?? ""),
              ),
              body: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  SizedBox(height: 12),
                  Align(
                      alignment: Alignment.center,
                      child: Image.network(product.image)),
                  SizedBox(height: 12),
                  Text(
                    product.description ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12),
                  Text(
                    product.salePrice.toString().priceLabel,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 12),
                  CustomBarChart(
                      availableQty: product.availableQty!,
                      soldQty: product.soldQty!)
                ],
              ));
        });
  }
}
