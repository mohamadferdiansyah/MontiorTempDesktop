import 'dart:convert';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:serial_communication_desktop/app/modules/layout/layout_controller.dart';
import '../models/room_model.dart';

class MqttService extends GetxService {
  late MqttServerClient client;

  @override
  void onInit() {
    super.onInit();
  }

  Future<MqttService> init() async {
    client = MqttServerClient(
      'broker.emqx.io',
      'flutter_client_${DateTime.now().millisecondsSinceEpoch}',
    );
    client.port = 1883;
    client.keepAlivePeriod = 60;
    client.logging(on: false);

    client.onConnected = () => print('Connected ke alat');
    client.onDisconnected = () => print('Disconnected dari alat');
    client.onSubscribed = (topic) => print('Subscribed to $topic');

    try {
      await client.connect();
      client.subscribe('esp32/test', MqttQos.atMostOnce);
      client.subscribe('esp32/control', MqttQos.atMostOnce);

      client.updates!.listen((events) {
        final recMess = events[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print('Received: $payload on topic: ${events[0].topic}');
        try {
          final decoded = json.decode(payload);
          final controller = Get.find<LayoutController>();

          if (events[0].topic == 'esp32/test' && decoded['room'] != null) {
            final room = decoded['room'].toString();
            final temp = decoded['temperature']?.toDouble() ?? 0.0;
            final hum = decoded['humidity']?.toDouble() ?? 0.0;

            if (controller.rooms.containsKey(room)) {
              controller.rooms[room]!.temperature = temp;
              controller.rooms[room]!.humidity = hum;
              controller.rooms[room] = controller.rooms[room]!; // trigger refresh
            } else {
              controller.rooms[room] = RoomModel(
                room: room,
                temperature: temp,
                humidity: hum,
              );
            }
            controller.rooms.refresh();
          }

          // Update status kipas per ruangan, payload wajib ada 'room'
          if (events[0].topic == 'esp32/control' && decoded['fan'] != null && decoded['room'] != null) {
            final room = decoded['room'].toString();
            final fan = decoded['fan'].toString().toUpperCase();
            if (controller.rooms.containsKey(room)) {
              controller.rooms[room]!.fanStatus = fan;
              controller.rooms[room] = controller.rooms[room]!; // trigger refresh
              controller.rooms.refresh();
            }
          }
        } catch (_) {}
      });
    } catch (e) {
      print('MQTT Error: $e');
    }
    return this;
  }

  void publish(String topic, String payload) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }
}