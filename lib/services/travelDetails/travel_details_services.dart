import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/travelDetails/travel_details_model.dart.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class TravelDetailsServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTravelDetails(TravelDetailsModel models,BuildContext context) async {
    await _db
        .collection(DbKey.c_travelDetails)
        .doc(models.id)
        .set(models.toMap())
        .whenComplete((){
      showSnackBar(title: "Travel Added", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
       Navigator.pop(context);
    });
  }

  Future<void> updateTravelDetails(TravelDetailsModel models,BuildContext context) async {
    await _db
        .collection(DbKey.c_travelDetails)
        .doc(models.id)
        .update(models.toMap())
        .whenComplete((){
      showSnackBar(title: "Travel Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> deleteTravelDetails(String id,BuildContext context) async {
    await _db
        .collection(DbKey.c_travelDetails)
        .doc(id)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Travel Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

}
