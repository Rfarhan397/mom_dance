class UserModel {
  String date;
  String userUID;
  DateTime timestamp;
  String name;
  String time;
  String email;
  String password;

  UserModel({
    required this.date,
    required this.userUID,
    required this.name,
    required this.email,
    required this.password,
    required this.time,
    DateTime? timestamp,
  })  : this.timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userUID': userUID,
      'name': name,
      'email': email,
      'time': time,
      'password': password,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return UserModel(
        date: '',
        userUID: '',
        email: '',
        name: '',
        password: '',
        time: '',
      );
    }
    return UserModel(
      date: map['date'] ?? '',
      userUID: map['userUID'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      password: map['password'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
