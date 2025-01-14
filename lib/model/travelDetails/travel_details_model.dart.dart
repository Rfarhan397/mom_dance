class TravelDetailsModel {
  String id;
  String date;
  String checkOutDate;
  String comp;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String location;
  String registration;
  String hotel;
  String confirmationImage;


  TravelDetailsModel({
    required this.id,
    required this.date,
    required this.checkOutDate,
    required this.comp,
    required this.userUID,
    required this.location,
    required this.registration,
    required this.hotel,
    required this.confirmationImage,
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
      'checkOutDate': checkOutDate,
      'comp': comp,
      'userUID': userUID,
      'location': location,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
      'registration': registration,
      'hotel': hotel,
      'confirmationImage': confirmationImage,
    };
  }

  factory TravelDetailsModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return TravelDetailsModel(
        id: '',
        date: '',
        checkOutDate: '',
        comp: '',
        userUID: '',
        location: '',
        registration: '',
        hotel: '',
        confirmationImage: '',
      );
    }
    return TravelDetailsModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      checkOutDate: map['checkOutDate'] ?? '',
      comp: map['comp'] ?? '',
      userUID: map['userUID'] ?? '',
      location: map['location'] ?? '',
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      currentDate: map['currentDate'] ?? '',
      currentTime: map['currentTime'] ?? '',
      registration: map['registration'] ?? '',
      hotel: map['hotel'] ?? '',
      confirmationImage: map['confirmationImage'] ?? '',
    );
  }
}
