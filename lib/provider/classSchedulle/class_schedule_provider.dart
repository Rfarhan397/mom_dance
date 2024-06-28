import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';

class ClassScheduleProvider extends ChangeNotifier{
  String _sunday = "";
  String _monday = "";
  String _lastUpdate = "";

  String get sunday => _sunday;
  String get monday => _monday;
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
          _lastUpdate = value.get(DbKey.k_lastUpdate) ?? "";
          notifyListeners();
        }else{
          _sunday = "";
          _monday = "";
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

  Future<void> saveClassSchedule({required id,required String sunday,required String monday}) async{
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
    });
  }



}