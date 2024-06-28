import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/danceModel/dance_album_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class DanceAlbumServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDanceAlbum(DanceAlbumModel album,BuildContext context) async {
    await _db
        .collection(DbKey.c_danceAlbum)
        .doc(album.id)
        .set(album.toMap())
        .whenComplete((){
      showSnackBar(title: "Album Added", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateDanceAlbum(DanceAlbumModel album,BuildContext context) async {
    await _db
        .collection(DbKey.c_danceAlbum)
        .doc(album.id)
        .update(album.toMap())
        .whenComplete((){
      showSnackBar(title: "Album updated", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> deleteDanceAlbum(String id,BuildContext context) async {
    await _db
        .collection(DbKey.c_danceAlbum)
        .doc(id)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Album Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

}
