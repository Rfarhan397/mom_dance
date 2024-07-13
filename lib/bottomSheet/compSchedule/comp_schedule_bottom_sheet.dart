import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/provider/pdf/pdf_provider.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';

class CompScheduleBottomSheet extends StatelessWidget {
  String id,competition,date,location,type;
  CompScheduleBottomSheet({super.key,
    this.id = '',
    this.competition = '',
    this.date = '',
    this.location = '',
    this.type = 'new',
  });

  var dateController = TextEditingController();
  var compController = TextEditingController();
  var locationController = TextEditingController();

   @override
  Widget build(BuildContext context) {
     final pdfProvider = Provider.of<PdfProvider>(context,listen: false);
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
            TextWidget(text: "Add Competition Schedule", size: 16.0,color: Colors.white,),
            SizedBox(height: 20.0,),
            TextWidget(text: "Date", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return CustomTextField(
                    callback: (){
                      selectDateRangeFun(context);
                    },
                    radius: 15.0,
                    hintText: provider.selectedDateRange == null ?
                    "Select Date" :
                    dateController.text = "${formatDateRange(provider.selectedDateRange)}",
                    controller: dateController
                );
              },
            ),
            SizedBox(height: 20.0,),
            TextWidget(text: "Competition", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? compController.text = competition : "Competition", controller: compController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Location", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? locationController.text = competition : "location", controller: locationController),

            Consumer<PdfProvider>(
             builder: (context,provider, child){
               return ButtonWidget(
                 borderColor: whiteColor,
                 textColor: Colors.black,
                 width: Get.width,
                 height: 50.0,
                 onClicked: () async {
                    String path =  await pickAndUpdateFile();
                    provider.setPdfFile(path);
                 },
                 text: provider.filePath.isNotEmpty ? "Pdf Selected Size" : 'Select PDF',
               );
             },
            ),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: type == "edit" ? "Update" :"Add", onClicked: () async{

              String downloadUrl = await pdfProvider.uploadToDatabase(pdfProvider.filePath);

              final compSchedule = CompScheduleModel(
                  id: type == "edit" ? id : autoID(),
                  date: dateController.text.toString().trim(),
                  comp: compController.text.toString().trim(),
                  location: locationController.text.toString().trim(),
                  userUID: auth.currentUser!.uid.toString(),
                pdfUrl: downloadUrl
              );

              if(type == "edit"){
                await CompJournalServices().updateCompSchedule(compSchedule, context);
              }else{
                await CompJournalServices().addCompSchedule(compSchedule, context);
              }
             dateController.text = "";
             compController.text = "";
              locationController.text = "";
              pdfProvider.clearPdfFile();
              Navigator.pop(context);

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
