class RoomModel {
  final String room;
  double temperature;
  double humidity;
  String fanStatus;

  RoomModel({
    required this.room,
    this.temperature = 0.0,
    this.humidity = 0.0,
    this.fanStatus = "OFF",
  });
}