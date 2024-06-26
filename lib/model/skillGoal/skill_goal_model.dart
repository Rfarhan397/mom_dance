class SkillGoalModel {
  String id;
  String dancerId;
  String date;
  String skill;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;

  SkillGoalModel({
    required this.id,
    required this.date,
    required this.skill,
    required this.dancerId,
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
      'date': date,
      'skill': skill,
      'dancerId': dancerId,
      'userUID': userUID,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory SkillGoalModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return SkillGoalModel(
        id: '',
        date: '',
        skill: '',
        userUID: '',
        dancerId: '',
      );
    }
    return SkillGoalModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      skill: map['skill'] ?? '',
      dancerId: map['dancerId'] ?? '',
      userUID: map['userUID'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
    );
  }
}
