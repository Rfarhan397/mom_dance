import 'package:flutter/material.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compPacking/comp_packing_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/danceModel/dance_album_model.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/favouriteLink/favourite_links_model.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/model/skillGoal/skill_goal_model.dart';
import 'package:mom_dance/model/travelDetails/travel_details_model.dart.dart';
import 'package:mom_dance/services/dancer/dancer_services.dart';

import '../../constant.dart';
import '../../model/compJournal/comp_journal_model.dart';


class DancerProvider with ChangeNotifier {
  final DancerServices _firestoreService = DancerServices();

  List<DancerModel> _dancers = [];

  List<DancerModel> get dancers => _dancers;


  Future<void> addDancer(DancerModel dancer,BuildContext context) async {
    await _firestoreService.addDancer(dancer,context);
    _dancers.add(dancer);
    _dancers.clear();
    notifyListeners();
  }

  Future<void> updateDancer(DancerModel dancer,BuildContext context) async {
    await _firestoreService.updateDancer(dancer,context);
    _dancers.add(dancer);
    _dancers.clear();
    notifyListeners();
  }

  Stream<List<DancerModel>> getMyDancers() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection('dancers').where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DancerModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<CompJournalModel>> getCompJournal({required String dancerID}) {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_dancers).doc(dancerID).collection(DbKey.c_compJournal).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CompJournalModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<DanceShoesModel>> getDanceShoes({required String dancerID}) {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_dancers).doc(dancerID).collection(DbKey.c_danceShoes).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DanceShoesModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<SkillGoalModel>> getSkillGoals({required String dancerID}) {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_dancers).doc(dancerID).collection(DbKey.c_skillGoals).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SkillGoalModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<CostumeChecklistModel>> getCostumeChecklist({required String dancerID}) {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_dancers).doc(dancerID).collection(DbKey.c_costumeChecklist).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CostumeChecklistModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<CompScheduleModel>> getCompSchedule() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_compSchedule).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CompScheduleModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<TravelDetailsModel>> getTravelDetails() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_travelDetails).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TravelDetailsModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<FavouriteLinksModel>> getFavouriteLinks() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_favouriteLinks).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FavouriteLinksModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<CompPackingModel>> getPacking() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_compPacking).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CompPackingModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<MusicLibraryModel>> getMusicLibrary() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_musicLibrary).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MusicLibraryModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<DanceAlbumModel>> getDanceAlbum() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_danceAlbum).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DanceAlbumModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<DanceAlbumModel>> getProfile() {
    String? userUID = auth.currentUser?.uid.toString();
    return firestore.collection(DbKey.c_users).where(DbKey.k_userUID, isEqualTo: userUID).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DanceAlbumModel.fromMap(doc.data());
      }).toList();
    });
  }
}
