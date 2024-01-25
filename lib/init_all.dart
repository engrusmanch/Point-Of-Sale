import 'package:point_of_sale/features/add_edit_product/init.dart';
import 'package:point_of_sale/features/dashboard/presentation/init_dashboard.dart';
import 'package:point_of_sale/features/product_detail/init_product.dart';

Future<void>initAll()async{
  initDashboard();
  initProduct();
  initAddEditProduct();
}