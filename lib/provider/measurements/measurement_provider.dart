import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';

class MeasurementProvider extends ChangeNotifier{
  String _shoulder = "";
  String _belli = "";
  String _leg = "";
  String _hip =  "";
  String _knee = "";
  String _lastUpdate = "";

  String get shoulder => _shoulder;
  String get belli => _belli;
  String get leg => _leg;
  String get hip => _hip;
  String get knee => _knee;
  String get lastUpdate =>_lastUpdate;


  Future<void> getMeasurement({required id}) async{
    try{
      await firestore.collection(DbKey.c_dancers)
          .doc(id)
          .collection(DbKey.c_measurement).doc("details")
       .get().then((value){
         if(value.exists){
           _shoulder = value.get(DbKey.k_shoulder) ?? "";
           _belli = value.get(DbKey.k_belli) ?? "";
           _leg = value.get(DbKey.k_leg) ?? "";
           _hip = value.get(DbKey.k_hip) ?? "";
           _knee = value.get(DbKey.k_knee) ?? "";
           _lastUpdate = value.get(DbKey.k_lastUpdate) ?? "";
           notifyListeners();
         }else{
            _shoulder = "";
            _belli = "";
            _leg = "";
            _hip =  "";
            _knee = "";
            _lastUpdate = "";
            addMeasurements(id);
            notifyListeners();
         }
      });
      notifyListeners();
    }catch(e){
      log(e.toString());
    }
  }

  Future<void> saveMeasurements({required id,required key,required value}) async{
    log("Save Measurements $id, $key $value");
    try{

      firestore.collection("dancers")
          .doc(id)
          .collection(DbKey.c_measurement).doc("details").update({
        key : value,
        DbKey.k_lastUpdate  : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      }).whenComplete((){
        showSnackBar(title: "new saved", subtitle: "");
      });

      notifyListeners();
    }catch(e){
      log("error: ${e.toString()}");
    }
  }

  void addMeasurements(id) async{
   await firestore.collection("dancers")
        .doc(id)
        .collection(DbKey.c_measurement).doc("details").set({
       DbKey.k_shoulder : "",
       DbKey.k_belli : "",
       DbKey.k_leg : "",
       DbKey.k_hip : "",
       DbKey.k_knee : "",
       DbKey.k_lastUpdate : "",
    });
  }



}