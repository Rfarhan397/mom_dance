class CompScheduleModel {
  String id;
  String date;
  String comp;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String location;


  CompScheduleModel({
    required this.id,
    required this.date,
    required this.comp,
    required this.userUID,
    required this.location,
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
      'comp': comp,
      'userUID': userUID,
      'location': location,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory CompScheduleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return CompScheduleModel(
        id: '',
        date: '',
        comp: '',
        userUID: '',
        location: '',
      );
    }
    return CompScheduleModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      comp: map['comp'] ?? '',
      userUID: map['userUID'] ?? '',
      location: map['location'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
