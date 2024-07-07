import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/compPacking/comp_packing_model.dart';

class PackingProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<CompPackingModel> _packingList = [];

  List<CompPackingModel> get packingList => _packingList;

  PackingProvider(){
    fetchPackingList();
  }

  Future<void> fetchPackingList() async {
    final snapshot = await _db.collection('compPacking').get();
    _packingList = snapshot.docs
        .map((doc) => CompPackingModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addCompPacking(CompPackingModel item) async {
    await _db.collection('compPacking').doc(item.id).set(item.toMap());
    _packingList.add(item);
    notifyListeners();
  }

  Future<void> updatePackingItem(CompPackingModel item) async {
    await _db.collection('compPacking').doc(item.id).update(item.toMap());
    final index = _packingList.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _packingList[index] = item;
      notifyListeners();
    }
  }

  void toggleMarking(CompPackingModel item) {
    item.isMarked = !item.isMarked;
    updatePackingItem(item);
  }
}
