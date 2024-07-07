class CompPackingModel {
  String id;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String name;
  bool isMarked;

  CompPackingModel({
    required this.id,
    required this.userUID,
    required this.name,
    this.isMarked = false,
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
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
      'isMarked': isMarked,
    };
  }

  factory CompPackingModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return CompPackingModel(
        id: '',
        userUID: '',
        name: '',
      );
    }
    return CompPackingModel(
      id: map['id'] ?? '',
      userUID: map['userUID'] ?? '',
      name: map['name'] ?? '',
      isMarked: map['isMarked'] ?? false,
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
