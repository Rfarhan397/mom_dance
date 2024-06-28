import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class MusicLibraryServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMusicLibrary(MusicLibraryModel musicLibrary,BuildContext context) async {
    await _db
        .collection(DbKey.c_musicLibrary)
        .doc(musicLibrary.id)
        .set(musicLibrary.toMap())
        .whenComplete((){
      showSnackBar(title: "Music Added", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

  Future<void> updateMusicLibrary(MusicLibraryModel musicLibrary,BuildContext context) async {
    await _db
        .collection(DbKey.c_musicLibrary)
        .doc(musicLibrary.id)
        .update(musicLibrary.toMap())
        .whenComplete((){
      showSnackBar(title: "Music Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

  Future<void> deleteMusicLibrary(String musicID,BuildContext context) async {
    await _db
        .collection(DbKey.c_musicLibrary)
        .doc(musicID)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Music Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }

}
