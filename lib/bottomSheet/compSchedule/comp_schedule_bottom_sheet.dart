import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
class CompScheduleBottomSheet extends StatelessWidget {
  CompScheduleBottomSheet({super.key});

  var dateController = TextEditingController();
  var compController = TextEditingController();
  var locationController = TextEditingController();

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
            TextWidget(text: "Add Comp Schedule", size: 16.0,color: Colors.white,),
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
                    "Select Date" :
                    dateController.text = "${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}",
                    controller: dateController
                );
              },
            ),
            SizedBox(height: 20.0,),
            TextWidget(text: "Comp", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "comp", controller: compController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Location", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "location", controller: locationController),


            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: "Add", onClicked: () async{


              final compSchedule = CompScheduleModel(
                  id: autoID(),
                  date: dateController.text.toString().trim(),
                  comp: compController.text.toString().trim(),
                  location: locationController.text.toString().trim(),
                  userUID: auth.currentUser!.uid.toString(),
              );

             await CompJournalServices().addCompSchedule(compSchedule, context);
             dateController.text = "";
             compController.text = "";
              locationController.text = "";
              Navigator.pop(context);

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
