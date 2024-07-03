import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/classSchedule/class_schedule_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/provider/classSchedulle/class_schedule_provider.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/res/appString/app_string.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/image_loader_widget.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';

class ClassScheduleScreen extends StatelessWidget {
  ClassScheduleScreen({super.key});

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final arguments = Get.arguments as Map<String, dynamic>? ?? {};
   final classProvider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<ClassScheduleProvider>(
            builder: (context,provider, child){
              return Column(
                children: [
                  SimpleHeader(text: "Class Schedule"),
                  Container(
                    width: Get.width,
                    height: Get.width * 0.450,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: ImageLoaderWidget(imageUrl: classProvider.classSchedule.toString(),),
                    ),
                  ),
                  SizedBox(height: 20.0,),

                  Container(
                    width: Get.width,
                    padding : EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: Colors.black,width: 1.0)
                    ),
                    child: TextWidget(text: "Sunday",size: 12.0,),
                  ),

                  Container(
                    width: Get.width,
                    padding : EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black,width: 1.0)
                    ),
                    child: TextWidget(text: provider.sunday,size: 12.0,),
                  ),


                  SizedBox(height: 20.0,),

                  Container(
                    width: Get.width,
                    padding : EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: Colors.black,width: 1.0)
                    ),
                    child: TextWidget(text: "Monday",size: 12.0,),
                  ),

                  Container(
                    width: Get.width,
                    padding : EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black,width: 1.0)
                    ),
                    child: TextWidget(text: provider.monday,size: 12.0,),
                  ),


                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(ClassScheduleBottomSheet(id: arguments['id'] ?? "null",));
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}




