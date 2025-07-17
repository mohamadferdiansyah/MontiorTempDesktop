import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/dashboard/dashboard_controller.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';
import 'package:serial_communication_desktop/app/widgets/custom_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final LayoutController controller = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Kontrol Ruangan',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suhu',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          'Suhu: ${controller.temperature.value} °C',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kelembapan',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          'Kelembapan: ${controller.humidity.value} %',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Text(
                'Kontrol Kipas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: controller.fanStatus.value == "ON"
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.fanStatus.value == "ON"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  child: Text(
                    'Status: ${controller.fanStatus.value}',
                    style: TextStyle(
                      color: controller.fanStatus.value == "ON"
                          ? Colors.green
                          : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Obx(
            () => CustomButton(
              backgroundColor: controller.fanStatus.value == "ON"
                  ? Colors.red
                  : Colors.green,
              onPressed: controller.toggleFan,
              text: controller.fanStatus.value == "ON"
                  ? "Matikan Kipas"
                  : "Nyalakan Kipas",
            ),
          ),
          Obx(
            () => controller.showFanAlert.value
                ? Center(
                    child: AlertDialog(
                      title: const Text('Peringatan Suhu Tinggi!'),
                      content: Text(
                        'Suhu ruangan di atas ${controller.threshold}°C.\nSegera nyalakan kipas.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: controller.toggleFan,
                          child: const Text('Nyalakan Kipas'),
                        ),
                        TextButton(
                          onPressed: () =>
                              controller.showFanAlert.value = false,
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
