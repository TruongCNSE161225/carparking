import 'dart:convert';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:carparkingapp/src/modals/wallet_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DepositController extends GetxController {
  TextEditingController depositController = TextEditingController();
  Rx<WalletModal> wallet = WalletModal().obs;

  Future<void> init() async {
    depositController.text = "";
    var prefs = await SharedPreferences.getInstance();
    String? walletJson = prefs.getString('wallet');
    if (walletJson != null) {
      wallet(WalletModal.fromJson(json.decode(walletJson.toString())));
    }
    super.onReady();
  }

  var moneyValue = ''.obs;
  get textMoney => moneyValue.value;

  String _paymentType = 'paypal';
  String get paymentType => _paymentType;

  void setPaymentType(String type) {
    _paymentType = type;
    update();
  }

  void onChangeTextValue() {
    moneyValue.value = depositController.text;
  }

  void clearText() {
    moneyValue.value = '';
    depositController.clear();
  }

  Future<Function()?> onPressed() async {
    if (double.parse(depositController.text) < 10000) {
      return Get.dialog(const AlertDialog(
        title: Text(
          'Lưu ý',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Nạp tối thiểu 10.000 VNĐ',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }
    await fetchWalletInquiry(depositController.text);

    return null;
  }

  Future<void> fetchWalletInquiry(String value) async {
    Utils.loading(Get.context!);
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}wallet/inquiry"),
      headers: Constants.header(token!),
      body: jsonEncode({
        "amount": double.parse(value),
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      var data = result['data'];
      final Uri url = Uri.parse(data['redirectUrl']);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch Paypal');
      }
    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
  }
}
