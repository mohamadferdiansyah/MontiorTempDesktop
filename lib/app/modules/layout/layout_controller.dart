import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/services/api_service.dart';
import 'package:serial_communication_desktop/app/services/mqtt_service.dart';
import '../dashboard/dashboard_page.dart';

class LayoutController extends GetxController {
  var currentPage = Rx<Widget>(DashboardPage());

  void navigateTo(Widget page) {
    currentPage.value = page;
  }

  void logout() async {
    final result = await ApiService.logout();
    if (result) {
      Get.snackbar('Logout Berhasil', 'Anda telah keluar.');
      Get.offAllNamed('/login'); // Redirect kembali ke halaman login
    } else {
      Get.snackbar('Logout Gagal', 'Silakan coba lagi.');
    }
  }

  final MqttService mqtt = Get.find();

  RxDouble get temperature => mqtt.temperature;
  RxDouble get humidity => mqtt.humidity;
  RxString get fanStatus =>
      mqtt.fanStatus; // Ambil langsung dari MQTT agar selalu update

  final RxBool showFanAlert = false.obs;
  final double threshold = 30.0;

  @override
  void onInit() {
    super.onInit();
    everAll([temperature, fanStatus], (_) {
      // Akan selalu mengecek setiap perubahan suhu ATAU status kipas
      if (temperature.value > threshold && fanStatus.value == "OFF") {
        showFanAlert.value = true;
      } else {
        showFanAlert.value = false;
      }
    });
  }

  void toggleFan() {
    if (fanStatus.value == "OFF") {
      mqtt.publish('esp32/control', '{ "fan": "ON" }');
    } else {
      mqtt.publish('esp32/control', '{ "fan": "OFF" }');
    }
    // Jangan set showFanAlert di sini!
  }
}
