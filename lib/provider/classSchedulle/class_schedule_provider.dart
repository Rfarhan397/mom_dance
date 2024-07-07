import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';

class ClassScheduleProvider extends ChangeNotifier{
  String _sunday = "";
  String _monday = "";
  String _tuesday = "";
  String _wednesday = "";
  String _thursday = "";
  String _friday = "";
  String _saturday = "";
  String _lastUpdate = "";

  String get sunday => _sunday;
  String get monday => _monday;
  String get tuesday => _tuesday;
  String get wednesday => _wednesday;
  String get thursday => _thursday;
  String get friday => _friday;
  String get saturday => _saturday;
  String get lastUpdate =>_lastUpdate;


  Future<void> getClassSchedule({required id}) async{
    try{
      await firestore.collection(DbKey.c_dancers)
          .doc(id)
          .collection(DbKey.c_classSchedule).doc("details")
          .get().then((value){
        if(value.exists){
          _sunday = value.get(DbKey.k_sunday) ?? "";
          _monday = value.get(DbKey.k_monday) ?? "";
          _tuesday = value.get(DbKey.k_tuesday) ?? "";
          _wednesday = value.get(DbKey.k_wednesday) ?? "";
          _thursday = value.get(DbKey.k_thursday) ?? "";
          _friday = value.get(DbKey.k_friday) ?? "";
          _saturday = value.get(DbKey.k_saturday) ?? "";
          _lastUpdate = value.get(DbKey.k_lastUpdate) ?? "";
          notifyListeners();
        }else{
          _sunday = "";
          _monday = "";
          _tuesday = "";
          _wednesday = "";
          _thursday = "";
          _friday = "";
          _saturday = "";
          _lastUpdate = "";
          addClassSchedule(id);
          notifyListeners();
        }
      });
      notifyListeners();
    }catch(e){
      log(e.toString());
    }
  }

  Future<void> saveClassSchedule({required id,required String sunday,required String monday,
  required String tuesday,required String wednesday,required String thursday,required String friday,
    required String saturday}) async{
   // log("Save Measurements $id, $key $value");
    try{


      if(sunday.isNotEmpty){
        await firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_sunday : sunday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }
      if(monday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_monday : monday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }

      if(tuesday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_tuesday : tuesday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }

      if(wednesday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_wednesday : wednesday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }


      if(thursday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_thursday : thursday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }

      if(friday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_friday : friday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }

      if(saturday.isNotEmpty){
        firestore.collection("dancers")
            .doc(id)
            .collection(DbKey.c_classSchedule).doc("details").update({
          DbKey.k_saturday : saturday,
          DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        }).whenComplete((){
          showSnackBar(title: "new saved", subtitle: "");
        });
      }

      notifyListeners();
    }catch(e){
      log("error: ${e.toString()}");
    }
  }


  void addClassSchedule(id) async{
    await firestore.collection("dancers")
        .doc(id)
        .collection(DbKey.c_classSchedule).doc("details").set({
      DbKey.k_monday : "",
      DbKey.k_sunday : "",
      DbKey.k_tuesday : "",
      DbKey.k_wednesday : "",
      DbKey.k_thursday : "",
      DbKey.k_friday : "",
      DbKey.k_saturday : "",
    });
  }



}