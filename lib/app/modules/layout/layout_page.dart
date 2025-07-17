import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';
import '../../widgets/sidebar.dart';

class LayoutPage extends StatelessWidget {
  final controller = Get.find<LayoutController>();

  LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(onMenuTap: controller.navigateTo),
          Expanded(
            child: Obx(() => Container(
                  color: Colors.grey[100],
                  child: controller.currentPage.value,
                )),
          ),
        ],
      ),
    );
  }
}
