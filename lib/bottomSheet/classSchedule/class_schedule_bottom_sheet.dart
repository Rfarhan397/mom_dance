import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/provider/classSchedulle/class_schedule_provider.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
class ClassScheduleBottomSheet extends StatelessWidget {
  final String id;
  ClassScheduleBottomSheet({super.key, required this.id});

  var sundayController = TextEditingController();
  var mondayController = TextEditingController();
  var tuesdayController = TextEditingController();
  var wednesdayController = TextEditingController();
  var thursdayController = TextEditingController();
  var fridayController = TextEditingController();
  var saturdayController = TextEditingController();


  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<ClassScheduleProvider>(context,listen: false);
     provider.getClassSchedule(id: id);
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
            TextWidget(text: "Add Dance Schedule", size: 16.0,color: Colors.white,),


            SizedBox(height: 20.0,),
            TextWidget(text: "Sunday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "enter schedule", controller: sundayController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Monday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Monday", controller: mondayController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Tuesday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Tuesday", controller: tuesdayController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Wednesday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Wednesday", controller: wednesdayController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Thursday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Thursday", controller: thursdayController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Friday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Friday", controller: fridayController),


            SizedBox(height: 20.0,),
            TextWidget(text: "Saturday", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Saturday", controller: saturdayController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: "Add", onClicked: () async{

              await provider.saveClassSchedule(
                  id: id,
                  sunday: sundayController.text.toString().trim(),
                  monday: mondayController.text.toString().trim(),
                  tuesday: tuesdayController.text.toString().trim(),
                  wednesday: wednesdayController.text.toString().trim(),
                 thursday: thursdayController.text.toString().trim(),
                 friday: fridayController.text.toString().trim(),
                 saturday: saturdayController.text.toString().trim(),
              );
              provider.getClassSchedule(id: id);
              Get.back();

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
