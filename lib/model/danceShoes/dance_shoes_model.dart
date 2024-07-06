class DanceShoesModel {
  String id;
  String dancerId;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String shoes;
  String brand;
  String size;
  String color;

  DanceShoesModel({
    required this.id,
    required this.dancerId,
    required this.userUID,
    required this.shoes,
    required this.brand,
    required this.size,
    required this.color,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ?? '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ?? '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dancerId': dancerId,
      'userUID': userUID,
      'shoes': shoes,
      'brand': brand,
      'color': color,
      'size': size,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory DanceShoesModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return DanceShoesModel(
        id: '',
        userUID: '',
        dancerId: '',
        shoes: '',
        brand: '',
        size: '',
        color: '',
      );
    }
    return DanceShoesModel(
      id: map['id'] ?? '',
      dancerId: map['dancerId'] ?? '',
      userUID: map['userUID'] ?? '',
      shoes: map['shoes'] ?? '',
      brand: map['brand'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
