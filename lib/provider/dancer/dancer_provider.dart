import 'package:flutter/material.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/skillGoal/skill_goal_model.dart';
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
}
