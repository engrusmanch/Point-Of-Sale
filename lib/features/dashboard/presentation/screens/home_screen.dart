import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/widgets/masonry_grid_view_separated_c.dart';
import 'package:point_of_sale/core/widgets/product_card.dart';
import 'package:point_of_sale/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:point_of_sale/features/product_detail/presentation/screen/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController) {
      return Scaffold(
        body: (dashboardController.listLoadingState.isLoaded)
            ? ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomGridViewSeparated(
                      itemCount: dashboardController.productList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                    id: dashboardController
                                        .productList[index].id,
                                  )));
                        },
                        child: ProductCard(
                            product: dashboardController.productList[index]),
                      ),
                    )),
              ])
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
