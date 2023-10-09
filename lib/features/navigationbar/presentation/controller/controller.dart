
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/home_screen.dart';

class NavigationController extends GetxController {
  final int? dynamicTabIndex;
  NavigationController({this.dynamicTabIndex});
  int selectedIndex = 0;
  bool onSelected = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (dynamicTabIndex != null) {
      onItemTapped(dynamicTabIndex!);
    }
  }

   List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
     HomeScreen(),
     HomeScreen(),
     HomeScreen(),
     HomeScreen(),
    // CategoryScreen(),
    // MyCartCustomer(),
    // MyWalletPage(),
    // AccountScreenCustomer(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    onSelected = true;
    update();
  }
}
