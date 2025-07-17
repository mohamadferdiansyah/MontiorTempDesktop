import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';

class Sidebar extends StatelessWidget {
  final Function(Widget) onMenuTap;

  const Sidebar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.blueGrey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            // onTap: () => onMenuTap(DashboardPage()),
          ),
          ListTile(
            leading: const Icon(Icons.usb, color: Colors.white),
            title: const Text('Ruangan', style: TextStyle(color: Colors.white)),
            // onTap: () => onMenuTap(SerialPage()),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.defaultDialog(
                title: 'Konfirmasi Logout',
                middleText: 'Apakah kamu yakin ingin keluar?',
                textCancel: 'Batal',
                textConfirm: 'Ya',
                buttonColor: Colors.red,
                confirmTextColor: Colors.white,
                onConfirm: () {
                  final controller = Get.find<LayoutController>();
                  controller.logout();
                  Get.back(); // Tutup dialog
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
