class DanceAlbumModel {
  String id;
  String image;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String name;

  DanceAlbumModel({
    required this.id,
    required this.image,
    required this.userUID,
    required this.name,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ?? '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ?? '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'userUID': userUID,
      'name': name,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory DanceAlbumModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return DanceAlbumModel(
        id: '',
        image: '',
        userUID: '',
        name: '',
      );
    }
    return DanceAlbumModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      userUID: map['userUID'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
