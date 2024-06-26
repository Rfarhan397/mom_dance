class CostumeChecklistModel {
  String id;
  String dancerId;
  String date;
  String image;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String dance;
  String costume;
  String accesspries;
  String shoes;

  CostumeChecklistModel({
    required this.id,
    required this.date,
    required this.image,
    required this.dancerId,
    required this.userUID,
    required this.dance,
    required this.costume,
    required this.accesspries,
    required this.shoes,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ?? '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ?? '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'image': image,
      'dancerId': dancerId,
      'userUID': userUID,
      'dance': dance,
      'costume': costume,
      'accesspries': accesspries,
      'shoes': shoes,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory CostumeChecklistModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return CostumeChecklistModel(
        id: '',
        date: '',
        image: '',
        userUID: '',
        dancerId: '',
        dance: '',
        costume: '',
        accesspries: '',
        shoes: '',
      );
    }
    return CostumeChecklistModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      image: map['image'] ?? '',
      dancerId: map['dancerId'] ?? '',
      userUID: map['userUID'] ?? '',
      dance: map['dance'] ?? '',
      costume: map['costume'] ?? '',
      accesspries: map['accesspries'] ?? '',
      shoes: map['shoes'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
