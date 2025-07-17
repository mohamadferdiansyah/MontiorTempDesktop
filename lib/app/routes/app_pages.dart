import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/login/login_binding.dart';
import 'package:serial_communication_desktop/app/modules/login/login_page.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_binding.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => LayoutPage(),
      binding: LayoutBinding(),
    ),
  ];
}
