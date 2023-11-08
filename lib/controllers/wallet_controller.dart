import 'dart:convert';

import 'package:carparkingapp/src/modals/wallet_modal.dart';
import 'package:carparkingapp/src/pages/home/home_controller.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  Rx<WalletModal?> wallet = Rx<WalletModal?>(null);

  init() {
    fetchWallet();
  }

  Future<void> fetchWallet() async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}wallet/detail/context"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      var data = WalletModal.fromJson(result['data']);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('wallet', json.encode(data.toJson()));
      HomeController().init();

    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
  }
}
