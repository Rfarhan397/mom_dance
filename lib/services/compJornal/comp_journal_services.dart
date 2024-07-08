import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class CompJournalServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addCompJournal(CompJournalModel compJournal,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_compJournal)
        .doc(compJournal.id)
        .set(compJournal.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp Added", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateCompJournal(CompJournalModel compJournal,BuildContext context,String dancerID,String compID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_compJournal)
        .doc(compID)
        .update(compJournal.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp Update", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }


  Future<void> deleteCompJournal({required String id,required BuildContext context,required String dancerID}) async {
    log("message ${id}-${dancerID}");
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID.toString())
        .collection(DbKey.c_compJournal)
        .doc(id.toString())
        .delete()
        .whenComplete((){
      showSnackBar(title: "Comp Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

  Future<void> addCompSchedule(CompScheduleModel compSchedule,BuildContext context) async {
    await _db
        .collection(DbKey.c_compSchedule)
        .doc(compSchedule.id)
        .set(compSchedule.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateCompSchedule(CompScheduleModel compSchedule,BuildContext context) async {
    await _db
        .collection(DbKey.c_compSchedule)
        .doc(compSchedule.id)
        .update(compSchedule.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp updated", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }


  Future<void> deleteCompSchedule(String id,BuildContext context) async {
    await _db
        .collection(DbKey.c_compSchedule)
        .doc(id)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Comp Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

  Future<void> updateDancer(DancerModel dancer,BuildContext context) async {
    await _db.collection(DbKey.c_dancers).doc(dancer.id).update(dancer.toMap()).whenComplete((){
      showSnackBar(title: "Dancer updated", subtitle: "");
     final provider = Provider.of<ImagePickProvider>(context,listen: false);
     if(provider.imageFile !=null){
       provider.clear();
     }
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }


}
