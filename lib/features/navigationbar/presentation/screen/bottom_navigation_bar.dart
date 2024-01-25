
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/core/constants/strings.dart';
import 'package:point_of_sale/core/widgets/search_bar_c.dart';
import 'package:point_of_sale/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/generic_scanner.dart';
import 'package:point_of_sale/features/navigationbar/presentation/controller/controller.dart';

class MyNavigationBar extends StatelessWidget {
  final int? dynamicTab;
  MyNavigationBar({Key? key, this.dynamicTab}) : super(key: key);

  // final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController=Get.find();
    return GetBuilder<NavigationController>(
        init: NavigationController(dynamicTabIndex: dynamicTab),
        builder: (navigationController) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Scaffold(
                appBar: (navigationController.selectedIndex == 4)
                    ? null
                    : AppBar(
                        toolbarHeight: 90,
                        actions: [
                          IconButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => NotificationScreen()));
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          )
                        ],
                        centerTitle: true,
                        backgroundColor: Theme.of(context).colorScheme.surface,

                        title: SearchFieldWithOptions(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => SearchScreen()));
                          },
                          hintText: searchForAnyProductLabel,
                          searchFieldType: SearchFieldType.appBar,
                          onChanged: dashboardController.searchProduct,
                        ),
                ),
                body: Center(
                  child: navigationController.widgetOptions
                      .elementAt(navigationController.selectedIndex),
                ),
                bottomNavigationBar: NavigationBarTheme(
                  data: NavigationBarThemeData(
                    indicatorColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: NavigationBar(
                    selectedIndex: navigationController.selectedIndex,
                    onDestinationSelected: navigationController.onItemTapped,
                    destinations:  [
                      NavigationDestination(
                        icon: Icon(
                          Icons.home_outlined,
                        ),
                        label: 'Home',
                        selectedIcon: Icon(
                          Icons.home_sharp,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.category_outlined),
                        label: 'Categories',
                        selectedIcon: Icon(Icons.category),
                      ),
                      InkWell(
                        onTap: ()async{
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GenericCodeScanner(
                                    scanBarCode: dashboardController.scanBarCode,
                                    scannerType: ScannerType.barCodeScanner,
                                  )));
                          Get.delete<CodeScannerController>();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary
                          ),
                          padding: EdgeInsets.only(bottom: 4),
                          height: 70,
                          width: 70,
                          child: Icon(
                              Icons.qr_code_scanner_outlined,
                              size: 40,
                            ),
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.wallet_sharp,
                        ),
                        label: 'Wallet',
                        selectedIcon: Icon(
                          Icons.wallet,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.person_outline,
                        ),
                        label: 'Account',
                        selectedIcon: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),
              )


              );
        });

  }
}
