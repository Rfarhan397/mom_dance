import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compPacking/comp_packing_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/favouriteLink/favourite_links_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/compPacking/packing_provider.dart';

class FavouriteLinksServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> addFavouriteLinks(FavouriteLinksModel links,BuildContext context) async {
    await _db
        .collection(DbKey.c_favouriteLinks)
        .doc(links.id)
        .set(links.toMap())
        .whenComplete((){
      showSnackBar(title: "Links Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateFavouriteLinks(FavouriteLinksModel links,BuildContext context) async {
    await _db
        .collection(DbKey.c_favouriteLinks)
        .doc(links.id)
        .update(links.toMap())
        .whenComplete((){
      showSnackBar(title: "Links Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }


  Future<void> deleteFavouriteLinks(String id,BuildContext context) async {
    await _db
        .collection(DbKey.c_favouriteLinks)
        .doc(id)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Comp Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

  Future<void> addCompPacking(CompPackingModel links,BuildContext context) async {
    await _db
        .collection(DbKey.c_compPacking)
        .doc(links.id)
        .set(links.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp Added", subtitle: "");
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateCompPacking(CompPackingModel links,BuildContext context) async {
    await _db
        .collection(DbKey.c_compPacking)
        .doc(links.id)
        .update(links.toMap())
        .whenComplete((){
      showSnackBar(title: "Comp Update", subtitle: "");
      Provider.of<PackingProvider>(context,listen: false).fetchPackingList();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
      Get.back();
      Get.back();
    });
  }

  Future<void> deleteCompPacking(String id,BuildContext context) async {
    log('message $id');
    await _db
        .collection(DbKey.c_compPacking)
        .doc(id)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Comp Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

}
