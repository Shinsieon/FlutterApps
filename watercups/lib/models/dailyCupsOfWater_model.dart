class DailyWaterCupsOfWater {
  final int cupSize;
  final int cupCount;
  final String cupType;
  DailyWaterCupsOfWater.fromJson(Map<String, dynamic> json)
      : cupSize = json['cupSize'],
        cupCount = json['cupCount'],
        cupType = json['cupType'];
}
