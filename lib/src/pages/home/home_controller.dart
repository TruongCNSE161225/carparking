import 'dart:convert';

import 'package:carparkingapp/src/modals/wallet_modal.dart';
import 'package:carparkingapp/src/pages/deposit/deposit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  Rx<bool> visionPrice = true.obs;
  Rx<WalletModal> wallet = WalletModal().obs;

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    String? walletJson = prefs.getString('wallet');
    if (walletJson != null) {
      wallet(WalletModal.fromJson(json.decode(walletJson.toString())));
    }
  }

  void deposit() {
    var depositController = Get.find<DepositController>();
    depositController.init();
    Get.toNamed('/deposit');
  }
}
