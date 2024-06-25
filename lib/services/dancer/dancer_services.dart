import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class DancerServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDancer(DancerModel dancer,BuildContext context) async {
    await _db.collection(DbKey.c_dancers).doc(dancer.id).set(dancer.toMap()).whenComplete((){
      showSnackBar(title: "Dancer Added", subtitle: "");
      Provider.of<ImagePickProvider>(context,listen: false).clear();
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

  // Future<List<DancerModel>> getDancers() async {
  //   QuerySnapshot snapshot = await _db.collection('dancers').get();
  //   return snapshot.docs.map((doc) => DancerModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  // }
}
