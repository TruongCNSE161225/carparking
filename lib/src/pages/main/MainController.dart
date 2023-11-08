import 'package:carparkingapp/controllers/wallet_controller.dart';
import 'package:carparkingapp/src/pages/bike/bike_controller.dart';
import 'package:carparkingapp/src/pages/bike/bike_page.dart';
import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:carparkingapp/src/pages/home/home_controller.dart';
import 'package:carparkingapp/src/pages/home/home_page.dart';
import 'package:carparkingapp/src/pages/profile/profile_controller.dart';
import 'package:carparkingapp/src/pages/profile/profile_page.dart';
import 'package:carparkingapp/src/pages/history/history_controller.dart';
import 'package:carparkingapp/src/pages/history/history_page.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  late HomeController _homeController;
  late BikeController _bikeController;
  late HistoryController _historyController;
  late ProfileController _profileController;
  late WalletController _walletController;
  late DepositController _depositController;

  PageStorageBucket bucket = PageStorageBucket();
  var currentTab = 0.obs;

  final List<Widget> _screens = [
    const HomePage(),
    const BikePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  Widget get currentScreen => _screens[currentTab.value];

  @override
  Future<void> onInit() async {
    initController();
    super.onInit();
  }

  @override
  void onReady() {
    var data = Get.parameters;
    if (data.isNotEmpty) {
      handleTransaction(data['transactionId']!);
    }
    super.onReady();
  }

  void initController() {
    Get.put(
      WalletController(),
      permanent: true,
    );
    _walletController = Get.find<WalletController>();
    _walletController.init();
    Get.put(
      HomeController(),
      permanent: true,
    );
    _homeController = Get.find<HomeController>();
    _homeController.init();

    Get.put(
      BikeController(),
      permanent: true,
    );
    _bikeController = Get.find<BikeController>();
    _bikeController.init();

    Get.put(
      HistoryController(),
      permanent: true,
    );
    _historyController = Get.find<HistoryController>();
    _historyController.init();

    Get.put(
      ProfileController(),
      permanent: true,
    );
    _profileController = Get.find<ProfileController>();
    _profileController.init();

    Get.put(
      DepositController(),
      permanent: true,
    );
    _depositController = Get.find<DepositController>();
    _depositController.init();
  }

  Future<void> handleTransaction(String id) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transactions/$id/detail"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      Utils.showDialogPopup(Get.context!, 'Thanh toán thành công');
      _walletController.init();
      _homeController.init();
    } else {}
  }

  void changeTab(int index) {
    currentTab.value = index;
    _walletController.init();
    switch (index) {
      case 0:
        _homeController.init();
        break;
      case 1:
        _bikeController.init();
        break;
      case 2:
        _historyController.init();
        break;
      case 3:
        _profileController.init();
        break;
    }
  }
}
