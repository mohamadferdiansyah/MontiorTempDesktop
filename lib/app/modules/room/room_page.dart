import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';
import 'package:serial_communication_desktop/app/widgets/custom_card.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final controller = Get.find<LayoutController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Kontrol Ruangan',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => controller.rooms.isEmpty
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          'Tidak ada ruangan yang tersedia',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: controller.rooms.entries.map((entry) {
                          final room = entry.value;
                          return RoomCard(
                            roomName: room.room,
                            temperature: room.temperature,
                            humidity: room.humidity,
                            fanStatus: room.fanStatus,
                            selected:
                                controller.selectedRoom.value == room.room,
                            onTap: () =>
                                controller.selectedRoom.value = room.room,
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
