import 'package:flutter/material.dart';
import 'dart:async';

class CountdownProvider with ChangeNotifier {
  Duration countdownDuration = Duration(
    days: 79, // 2 months and 19 days
    hours: 21,
    minutes: 1,
  );

  late Timer timer;

  CountdownProvider() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => updateCountdown());
  }

  void updateCountdown() {
    countdownDuration -= Duration(seconds: 1);
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
