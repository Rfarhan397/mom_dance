class DancerModel {
  String id;
  String name;
  String image;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;

  DancerModel({
    required this.id,
    required this.name,
    required this.image,
    required this.userUID,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ?? '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ?? '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'userUID': userUID,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory DancerModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return DancerModel(
        id: '',
        name: '',
        image: '',
        userUID: '',
      );
    }
    return DancerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      userUID: map['userUID'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
