import 'package:carparkingapp/src/pages/bike/bike_controller.dart';
import 'package:get/get.dart';

class BikeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BikeController());
  }

}