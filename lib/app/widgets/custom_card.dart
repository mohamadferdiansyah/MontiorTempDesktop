import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final double temperature;
  final double humidity;
  final String fanStatus;
  final bool selected;
  final VoidCallback onTap;

  const RoomCard({
    Key? key,
    required this.roomName,
    required this.temperature,
    required this.humidity,
    required this.fanStatus,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: selected ? 6 : 2,
      borderRadius: BorderRadius.circular(18),
      color: selected ? Colors.blueAccent : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 4 - 32,
          height: MediaQuery.of(context).size.width / 6 - 32,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? Colors.blueAccent : Colors.grey.shade300,
              width: selected ? 2.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                roomName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: selected ? Colors.white : Colors.blueGrey,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Suhu: ${temperature.toStringAsFixed(1)} °C",
                style: TextStyle(
                  fontSize: 15,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Kelembapan: $humidity",
                style: TextStyle(
                  fontSize: 15,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: fanStatus == "ON" ? Colors.green : Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Kipas: $fanStatus",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
