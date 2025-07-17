import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/models/room_model.dart';
import 'package:serial_communication_desktop/app/services/api_service.dart';
import 'package:serial_communication_desktop/app/services/mqtt_service.dart';
import '../dashboard/dashboard_page.dart';

class LayoutController extends GetxController {
  var currentPage = Rx<Widget>(DashboardPage());
  final MqttService mqtt = Get.find();

  final rooms = <String, RoomModel>{}.obs;
  final selectedRoom = ''.obs;

  // Getter untuk suhu, kelembapan, status kipas ruangan yang dipilih
  double get temperature => rooms[selectedRoom.value]?.temperature ?? 0.0;
  double get humidity => rooms[selectedRoom.value]?.humidity ?? 0.0;
  String get fanStatus => rooms[selectedRoom.value]?.fanStatus ?? "OFF";

  final RxBool showFanAlert = false.obs;
  final double threshold = 30.0;

  void navigateTo(Widget page) {
    currentPage.value = page;
  }

  @override
  void onInit() {
    super.onInit();
    // Default pilih ruangan pertama jika ada
    ever(rooms, (_) {
      if (selectedRoom.value.isEmpty && rooms.isNotEmpty) {
        selectedRoom.value = rooms.keys.first;
      }
    });

    everAll([RxDouble(temperature), RxString(fanStatus)], (_) {
      if (temperature > threshold && fanStatus == "OFF") {
        showFanAlert.value = true;
      } else {
        showFanAlert.value = false;
      }
    });
  }

  void toggleFan() {
    final newStatus = fanStatus == "OFF" ? "ON" : "OFF";
    mqtt.publish('esp32/control', '{ "fan": "$newStatus", "room": "${selectedRoom.value}" }');
    // Status akan diupdate otomatis saat MQTT menerima balasan dari ESP32
  }

  void logout() async {
    final result = await ApiService.logout();
    if (result) {
      Get.snackbar('Logout Berhasil', 'Anda telah keluar.');
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Logout Gagal', 'Silakan coba lagi.');
    }
  }
}
