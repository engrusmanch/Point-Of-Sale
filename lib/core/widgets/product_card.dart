import 'package:flutter/material.dart';
import 'package:point_of_sale/core/enums.dart';
import 'package:point_of_sale/features/add_edit_product/presentation/screens/add_edit_product.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/product_detail/presentation/screen/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;


  ProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.43,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Card(
                    // margin: EdgeInsets.all(8),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            product.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '\$${product.salePrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                              icon: Icon(Icons.remove_red_eye_outlined),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                          id: product.id!,
                                          product: product,
                                        )));
                              },
                              label: Text("View"))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(),
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            // bottom: 90,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.outline)),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      product.image.isEmpty
                          ? "https://media.istockphoto.com/id/1324356458/vector/picture-icon-photo-frame-symbol-landscape-sign-photograph-gallery-logo-web-interface-and.jpg?s=612x612&w=0&k=20&c=ZmXO4mSgNDPzDRX-F8OKCfmMqqHpqMV6jiNi00Ye7rE="
                          : product.image,
                      height: 100,
                      width: 130,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      // height: .0,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddEditProductPage(
                                    opType: OperationType.edit,
                                    index: index,
                                  )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          child: Icon(Icons.edit_outlined),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
