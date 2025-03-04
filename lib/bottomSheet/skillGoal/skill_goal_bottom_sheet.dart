import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/model/skillGoal/skill_goal_model.dart';
import 'package:mom_dance/services/skillGoal/skill_goall_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';

class SkillGoalBottomSheet extends StatelessWidget {
  final String id;
  String skillID,skill,date,type,dancerID;
  SkillGoalBottomSheet({super.key, required this.id,
  this.skill = '',
  this.skillID = '',
  this.date = '',
  this.type = 'new',
  this.dancerID = '',
  });

  var dateController = TextEditingController();
  var skillController = TextEditingController();


   DateTime? _selectedDate;


   @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: type == "edit" ? "Update Skill Goal" :"Add Skill Goal", size: 16.0,color: Colors.white,),

            SizedBox(height: 20.0,),
            TextWidget(text: "Skill", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ?skillController.text = skill  :"skill", controller: skillController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Date", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return CustomTextField(
                    callback: (){
                      selectDateFun(context,_selectedDate);
                    },
                    radius: 15.0,
                    hintText: provider.selectedDate == null ?
                    type == "edit" ? dateController.text = date  : "select date" :
                    dateController.text = "${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}",
                    controller: dateController
                );
              },
            ),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text:type == "edit" ? "Update" :  "Add", onClicked: () async{


              final skillModel = SkillGoalModel(
                  id: type == "edit" ? id : autoID(),
                  date: dateController.text.toString().trim(),
                  skill: skillController.text.toString().trim(),
                  dancerId:type == "edit" ? dancerID : id,
                  userUID: auth.currentUser!.uid.toString(),
              );

              if(type == "edit"){
                await SkillGoallServices().updateSkillGoal(skillModel, context, id);
              }else{
                await SkillGoallServices().addSkillGoal(skillModel, context, id);
              }

             dateController.text = "";
             skillController.text = "";
              Get.back();
            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
