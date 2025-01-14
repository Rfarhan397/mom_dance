import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
class CompBottomSheet extends StatelessWidget {
  final String id;

  String date,comp,dance,adjuction,overAll,special,compID,type,dancerID;
   CompBottomSheet({super.key,
     required this.id,
     this.date = '',
     this.comp = 'comp',
     this.dance = '',
     this.adjuction = '',
     this.overAll = '',
     this.special = '',
     this.compID = '',
     this.dancerID = '',
     this.type = 'new',
   });

  var dateController = TextEditingController();
  var compController = TextEditingController();
  var daceController = TextEditingController();
  var overAllController = TextEditingController();
  var adjuctionController = TextEditingController();
  var specialController = TextEditingController();

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
            TextWidget(text: "Add Comp Entry", size: 16.0,color: Colors.white,),
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
                    type == "edit" ? dateController.text = date : "select date" :
                    dateController.text = "${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}",
                    controller: dateController
                );
              },
            ),
            SizedBox(height: 20.0,),
            TextWidget(text: "Competition", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? compController.text = comp : "competition", controller: compController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Dance", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? daceController.text = dance : "dance", controller: daceController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Adjudication", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? adjuctionController.text = adjuction :   "adjudication", controller: adjuctionController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Overall", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? overAllController.text = overAll :  "overall", controller: overAllController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Specialty Award", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? specialController.text = special :  "special", controller: specialController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: type == "edit" ? "Update" : "Add", onClicked: () async{


              final compJournal = CompJournalModel(
                  id: type == "edit" ? compID : autoID(),
                  date: dateController.text.toString().trim(),
                  comp: compController.text.toString().trim(),
                  dancerId: type == "edit" ? dancerID : id,
                  userUID: auth.currentUser!.uid.toString(),
                  dance: daceController.text.toString().trim(),
                  adjuction: adjuctionController.text.toString().trim(),
                  overAll: overAllController.text.toString().trim(),
                  special: specialController.text.toString().trim(),
              );

              if(type == "edit"){
                await CompJournalServices().updateCompJournal(compJournal, context, dancerID,compID);
              }else{
                await CompJournalServices().addCompJournal(compJournal, context, id);
              }

             dateController.text = "";
             compController.text = "";
             daceController.text = "";
             adjuctionController.text = "";
             overAllController.text = "";
             specialController.text = "";
            //  Get.back();

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
