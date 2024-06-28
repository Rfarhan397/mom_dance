
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mom_dance/db_key.dart';

import '../../constant.dart';

class UserProvider with ChangeNotifier {
  String? _name;
  bool _isLoading = false;

  String? get name => _name;
  bool get isLoading => _isLoading;

  Future<void> fetchUserProfile() async {
    final uid = auth.currentUser?.uid;
    log("Runnning Profile");
    try {
      final value = await firestore.collection(DbKey.c_users).doc(uid).get();
      if (value.exists) {
        _name = value.get("name").toString();

        notifyListeners();
      } else {
        _name = "";
      }
      notifyListeners();
    } catch (e) {
      log("Error fetching account data: $e");
      if (kDebugMode) {
        print("Error fetching account data: $e");
      }
    }
    notifyListeners();
  }
}
