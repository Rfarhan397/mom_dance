import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/skillGoal/skill_goal_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/skillGoal/skill_goal_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/skillGoal/skill_goall_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/image_loader_widget.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';

class SkiillGoalScreen extends StatelessWidget {
  SkiillGoalScreen({super.key});

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final arguments = Get.arguments as Map<String, dynamic>? ?? {};
   final provider = Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SimpleHeader(text: "Skill Goal"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.skillGoals.toString(),),
                ),
              ),
              SizedBox(height: 20.0,),
              Table(
                border: TableBorder.all(width: 1.0,color: Colors.black),
                columnWidths: {
                  0 : FlexColumnWidth(1),
                  1 : FlexColumnWidth(1),
                  2 : FlexColumnWidth(1),
                  3 : FlexColumnWidth(1),
                  4 : FlexColumnWidth(1),
                  5 : FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Skill", size: 12.0,color: Colors.white,))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Date Achieved", size: 12.0,color: Colors.white))),
                    ]
                  )
                ],
              ),
              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<SkillGoalModel>>(
                    stream: productProvider.getSkillGoals(dancerID: arguments['id'] ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No skill goals found'));
                      }

                      List<SkillGoalModel> skillGoals = snapshot.data!;
                      return ListView.builder(
                        itemCount: skillGoals.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                         SkillGoalModel model = skillGoals[index];
                         log("message${model.date}");
                          return  GestureDetector(
                            onTap: (){
                              showCustomDialog(
                                  isThird: false,
                                  isSecond: true,
                                  onDelete: () async{
                                    await  SkillGoallServices().deleteKillGoal(model.id, context,model.dancerId);
                                    Get.back();
                                  }, onDetails: (){}, onEdit: (){
                                Navigator.pop(context);
                                Get.bottomSheet(SkillGoalBottomSheet(
                                  id: model.id,
                                  skill: model.skill,
                                  date: model.date,
                                  dancerID: model.dancerId,
                                  type: 'edit',
                                ));
                              });
                            },
                            child: Table(
                              border: TableBorder.all(width: 1.0,color: Colors.black),
                              columnWidths: {
                                0 : FlexColumnWidth(1),
                                1 : FlexColumnWidth(1),
                                2 : FlexColumnWidth(1),
                                3 : FlexColumnWidth(1),
                                4 : FlexColumnWidth(1),
                                5 : FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.skill, size: 12.0,color: Colors.black,))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.date, size: 12.0,color: Colors.black))),
                                    ]
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(SkillGoalBottomSheet(id: arguments['id'] ?? "null",));
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}




