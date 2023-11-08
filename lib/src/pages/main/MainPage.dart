import 'package:carparkingapp/src/pages/Main/MainController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: PageStorage(
                bucket: controller.bucket, child: controller.currentScreen),
            extendBody: true,
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              child: NavigationBar(
                backgroundColor: const Color(0xFF064789),
                onDestinationSelected: (int index) {
                  controller.changeTab(index);
                },
                indicatorColor: Colors.white,
                selectedIndex: controller.currentTab.value,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      color: Color(0xFF064789),
                    ),
                    icon: Icon(Icons.home_outlined, color: Colors.white),
                    label: 'Trang chủ',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.directions_bike_rounded,
                      color: Color(0xFF064789),
                    ),
                    icon: Icon(Icons.directions_bike_rounded,
                        color: Colors.white),
                    label: 'Phương tiện',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.history,
                      color: Color(0xFF064789),
                    ),
                    icon: Icon(Icons.history, color: Colors.white),
                    label: 'Giao dịch',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.account_circle_rounded,
                      color: Color(0xFF064789),
                    ),
                    icon: Icon(Icons.account_circle_outlined,
                        color: Colors.white),
                    label: 'Tài khoản',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
