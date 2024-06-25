class CompJournalModel {
  String id;
  String dancerId;
  String date;
  String comp;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String dance;
  String adjuction;
  String overAll;
  String special;

  CompJournalModel({
    required this.id,
    required this.date,
    required this.comp,
    required this.dancerId,
    required this.userUID,
    required this.dance,
    required this.adjuction,
    required this.overAll,
    required this.special,
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
      'dancerId': dancerId,
      'userUID': userUID,
      'dance': dance,
      'adjuction': adjuction,
      'overAll': overAll,
      'special': special,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory CompJournalModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return CompJournalModel(
        id: '',
        date: '',
        comp: '',
        userUID: '',
        dancerId: '',
        dance: '',
        adjuction: '',
        overAll: '',
        special: '',
      );
    }
    return CompJournalModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      comp: map['comp'] ?? '',
      dancerId: map['dancerId'] ?? '',
      userUID: map['userUID'] ?? '',
      dance: map['dance'] ?? '',
      overAll: map['overAll'] ?? '',
      special: map['special'] ?? '',
      adjuction: map['adjuction'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
