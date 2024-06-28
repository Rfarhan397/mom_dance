class MusicLibraryModel {
  String id;
  String image;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String name;
  String musicUrl;

  MusicLibraryModel({
    required this.id,
    required this.image,
    required this.userUID,
    required this.name,
    required this.musicUrl,
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
      'musicUrl': musicUrl,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory MusicLibraryModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return MusicLibraryModel(
        id: '',
        image: '',
        userUID: '',
        name: '',
        musicUrl: '',
      );
    }
    return MusicLibraryModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      userUID: map['userUID'] ?? '',
      musicUrl: map['musicUrl'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
