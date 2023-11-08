import 'dart:convert';

import 'package:carparkingapp/src/modals/order_modal.dart';
import 'package:carparkingapp/utils/constants.dart';
import 'package:carparkingapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryController extends GetxController {
  late Rx<OrderModal> orders = Rx(OrderModal());
  ScrollController scrollController = ScrollController();
  void init() {
    fetchOrder(0, 50);
  }

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  void _scrollListener() {
    // debugPrint(scrollController.position.extentAfter.toString());
    if (scrollController.position.extentAfter < 100) {
      // fetchOrder(1, 10);
    }
  }

  Future<void> fetchOrder(int number, int size) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}transactions/page?number=$number&size=$size"),
      headers: Constants.header(token!),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      OrderModal orderModal = OrderModal.fromJson(result['data']);
      orders = orderModal.obs;
      update();
    } else if (response.statusCode == 401) {
      Utils.handleError401();
    }
  }
}
