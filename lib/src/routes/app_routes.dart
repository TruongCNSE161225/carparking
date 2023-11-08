// ignore_for_file: constant_identifier_names
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
  static const BIKE = _Paths.BIKE;
  static const HISTORY = _Paths.HISTORY;
  static const DEPOSIT = _Paths.DEPOSIT;
}

abstract class _Paths {
  _Paths._();
  static const MAIN = '/main';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const BIKE = '/bike';
  static const HISTORY = '/history';
  static const DEPOSIT = '/deposit';
}
