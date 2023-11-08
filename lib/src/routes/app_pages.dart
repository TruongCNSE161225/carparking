import 'package:carparkingapp/src/pages/Main/MainBinding.dart';
import 'package:carparkingapp/src/pages/Main/MainPage.dart';
import 'package:carparkingapp/src/pages/bike/bike_binding.dart';
import 'package:carparkingapp/src/pages/bike/bike_page.dart';
import 'package:carparkingapp/src/pages/deposit/deposit_binding.dart';
import 'package:carparkingapp/src/pages/deposit/deposit_page.dart';
import 'package:carparkingapp/src/pages/home/home_binding.dart';
import 'package:carparkingapp/src/pages/home/home_page.dart';
import 'package:carparkingapp/src/pages/login/login_binding.dart';
import 'package:carparkingapp/src/pages/login/login_page.dart';
import 'package:carparkingapp/src/pages/profile/profile_binding.dart';
import 'package:carparkingapp/src/pages/profile/profile_page.dart';
import 'package:carparkingapp/src/pages/history/history_binding.dart';
import 'package:carparkingapp/src/pages/history/history_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.BIKE,
      page: () => const BikePage(),
      binding: BikeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.DEPOSIT,
      page: () => const DepositPage(),
      binding: DepositBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
