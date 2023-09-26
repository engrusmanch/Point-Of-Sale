import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/widgets/masonry_grid_view_separated_c.dart';
import 'package:point_of_sale/core/widgets/product_card.dart';
import 'package:point_of_sale/features/dashboard/presentation/get/dashboard_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: (dashboardController.listLoadingState.isLoaded)
            ? ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomGridViewSeparated(
                      itemCount: dashboardController.productList.length,
                      itemBuilder: (context, index) => ProductCard(
                          product: dashboardController.productList[index]),
                    )),
              ])
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
