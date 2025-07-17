import 'dart:convert';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService extends GetxService {
  late MqttServerClient client;
  final RxDouble temperature = 0.0.obs;
  final RxDouble humidity = 0.0.obs; // Tambahkan ini
  final RxString fanStatus = "OFF".obs;

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
        final payload = MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message,
        );
        print('Received: $payload on topic: ${events[0].topic}');
        try {
          final decoded = json.decode(payload);
          if (events[0].topic == 'esp32/test') {
            if (decoded['temperature'] != null) {
              temperature.value = decoded['temperature'].toDouble();
            }
            if (decoded['humidity'] != null) {
              humidity.value = decoded['humidity'].toDouble();
            }
          }
          if (events[0].topic == 'esp32/control' && decoded['fan'] != null) {
            fanStatus.value = decoded['fan'].toString().toUpperCase();
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
