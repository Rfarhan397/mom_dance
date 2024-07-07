import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/classSchedule/class_schedule_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/provider/classSchedulle/class_schedule_provider.dart';
import 'package:mom_dance/screen/classSchedule/components/weeks_widget.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/image_loader_widget.dart';
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
              return SingleChildScrollView(
                child: Column(
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
                    WeeksWidget(weekName: "Sunday", value: provider.sunday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Monday", value: provider.monday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Tuesday", value: provider.tuesday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Wednesday", value: provider.wednesday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Thursday", value: provider.thursday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Friday", value: provider.friday),
                
                    SizedBox(height: 20.0,),
                    WeeksWidget(weekName: "Saturday", value: provider.saturday),
                
                
                
                  ],
                ),
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




