// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class CountdownProvider with ChangeNotifier {
//   Duration countdownDuration = Duration(
//     days: 79, // 2 months and 19 days
//     hours: 21,
//     minutes: 1,
//   );
//
//   late Timer timer;
//
//   CountdownProvider() {
//     timer = Timer.periodic(Duration(seconds: 1), (_) => updateCountdown());
//   }
//
//   void updateCountdown() {
//     countdownDuration -= Duration(seconds: 1);
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:mom_dance/constant.dart';

class CountdownProvider with ChangeNotifier {
  Duration countdownDuration = Duration.zero;
  late Timer timer;

  CountdownProvider() {
    fetchInitialCountdown();
  }

  Future<void> fetchInitialCountdown() async {
    final auth = FirebaseAuth.instance.currentUser!.uid.toString();
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('countdowns').doc(auth).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        DateTime endTime = (data['endTime'] as Timestamp).toDate();
        countdownDuration = endTime.difference(DateTime.now());
        _startTimer();
        notifyListeners();

      }
    } catch (e) {
      print('Error fetching countdown: $e');
    }
  }

  Future<void> setCountdownTimestamp(DateTime endTime) async {
    final auth = FirebaseAuth.instance.currentUser!.uid.toString();
    try {
      await FirebaseFirestore.instance
          .collection('countdowns')
          .doc(auth)
          .set({'endTime': endTime});
      countdownDuration = endTime.difference(DateTime.now());
      _startTimer();
      fetchInitialCountdown();
      notifyListeners();
    } catch (e) {
      print('Error setting countdown timestamp: $e');
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

  void _updateCountdown() {
    countdownDuration -= Duration(seconds: 1);
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

