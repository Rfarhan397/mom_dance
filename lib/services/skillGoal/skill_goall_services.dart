import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/model/skillGoal/skill_goal_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class SkillGoallServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSkillGoal(SkillGoalModel skillModel,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_skillGoals)
        .doc(skillModel.id)
        .set(skillModel.toMap())
        .whenComplete((){
      showSnackBar(title: "Skill Added", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateSkillGoal(SkillGoalModel skillModel,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(skillModel.dancerId)
        .collection(DbKey.c_skillGoals)
        .doc(skillModel.id)
        .update(skillModel.toMap())
        .whenComplete((){
      showSnackBar(title: "Skill Added", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> deleteKillGoal(String skillId,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_skillGoals)
        .doc(skillId)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Skill Deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }


}
