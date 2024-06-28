class FavouriteLinksModel {
  String id;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String name;
  String link;

  FavouriteLinksModel({
    required this.id,
    required this.userUID,
    required this.name,
    required this.link,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ?? '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ?? '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userUID': userUID,
      'name': name,
      'link': link,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory FavouriteLinksModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return FavouriteLinksModel(
        id: '',
        userUID: '',
        link: '',
        name: '',
      );
    }
    return FavouriteLinksModel(
      id: map['id'] ?? '',
      userUID: map['userUID'] ?? '',
      link: map['link'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
