import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
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
