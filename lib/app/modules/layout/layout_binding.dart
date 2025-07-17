import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';
import 'package:serial_communication_desktop/app/services/mqtt_service.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MqttService>(MqttService()..init());
    Get.lazyPut<LayoutController>(() => LayoutController());
  }
}
