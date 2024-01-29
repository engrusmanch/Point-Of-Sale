import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/core/widgets/masonry_grid_view_separated_c.dart';
import 'package:point_of_sale/core/widgets/product_card.dart';
import 'package:point_of_sale/features/add_edit_product/presentation/screens/add_edit_product.dart';
import 'package:point_of_sale/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:point_of_sale/features/product_detail/presentation/screen/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController) {
      return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Product"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AddEditProductPage(opType: OperationType.add)));
          },
        ),
        body: (dashboardController.listLoadingState.isLoaded)
            ? RefreshIndicator(
                onRefresh: () async =>
                    await dashboardController.getProductsList(),
                child: ListView(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomGridViewSeparated(
                        itemCount: dashboardController.productList.length,
                        itemBuilder: (context, index) => ProductCard(
                            index: index,
                            product: dashboardController.productList[index]),
                      )),
                  SizedBox(
                    height: 50,
                  )
                ]),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
