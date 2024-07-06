
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mom_dance/db_key.dart';

import '../../constant.dart';

class UserProvider with ChangeNotifier {
  String? _name;
  String? _lastName;
  String? _homeText;
  String? _classSchedule;
  String? _compJournal;
  String? _compSchedule;
  String? _costumeChecklist;
  String? _costumeMeasurements;
  String? _danceAlbum;
  String? _danceShoes;
  String? _musicLibrary;
  String? _skillGoals;
  String? _travelDetails;
  bool _isLoading = false;

  String? get name => _name;
  String? get lastName => _lastName;
  String? get classSchedule => _classSchedule;
  String? get compJournal => _compJournal;
  String? get compSchedule => _compSchedule;
  String? get costumeChecklist => _costumeChecklist;
  String? get costumeMeasurements => _costumeMeasurements;
  String? get danceAlbum => _danceAlbum;
  String? get danceShoes => _danceShoes;
  String? get musicLibrary => _musicLibrary;
  String? get skillGoals => _skillGoals;
  String? get travelDetails => _travelDetails;
  String? get homeText => _homeText;

  bool get isLoading => _isLoading;


  UserProvider(){
    fetchBannerImages();
  }

  Future<void> fetchUserProfile() async {
    final uid = auth.currentUser?.uid;
    log("Runnning Profile");
    try {
      final value = await firestore.collection(DbKey.c_users).doc(uid).get();
      if (value.exists) {
        _name = value.get("name").toString();
        _lastName = value.get(DbKey.k_lastName).toString();

        notifyListeners();
      } else {
        _name = "";
        _lastName = "";
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


  Future<void> fetchBannerImages() async {
    log("Runnning Profile");
    try {
      final value = await firestore.collection("banner").doc("banners").get();
      if (value.exists) {
        _classSchedule= value.get("classSchedule").toString();
        _compJournal= value.get("compJournal").toString();
        _compSchedule= value.get("compSchedule").toString();
        _costumeChecklist= value.get("costumeChecklist").toString();
        _costumeMeasurements= value.get("costumeMeasurements").toString();
        _danceAlbum= value.get("danceAlbum").toString();
        _danceShoes= value.get("danceShoes").toString();
        _musicLibrary= value.get("musicLibrary").toString();
        _skillGoals= value.get("skillGoals").toString();
        _travelDetails= value.get("travelDetails").toString();
        _homeText= value.get("text").toString();
        notifyListeners();
      } else {
        _homeText = "";
        _classSchedule = "";
        _compJournal = "";
        _compSchedule = "";
        _costumeChecklist = "";
        _costumeMeasurements = "";
        _danceAlbum = "";
        _danceShoes = "";
        _musicLibrary = "";
        _skillGoals = "";
        _travelDetails = "";
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
