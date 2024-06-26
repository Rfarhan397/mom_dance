import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/bottomSheet/measurement/measurement_bottom_sheet.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/provider/measurements/measurement_provider.dart';
import 'package:mom_dance/res/appString/app_string.dart';
import 'package:provider/provider.dart';

import '../../helper/simple_header.dart';
import '../../res/appAsset/app_assets.dart';
class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final id = arguments['id'] ?? "";
    log("Dancer ID: " + id);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
               const SimpleHeader(text: "Measurement"),
                Container(
                  width: Get.width,
                  height: Get.width * 0.450,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(AppAssets.costume_measurement,fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(child: Image.asset(AppAssets.body)),
                    SizedBox(width: 10.0,),
                    Expanded(
                        flex: 2,
                        child: BodyDiagram(id: id,))
                  ],
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BodyDiagram extends StatelessWidget {
  final String id;
  const BodyDiagram({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<MeasurementProvider>(
     builder: (context,provider, child){
       provider.getMeasurement(id: id);
       return Center(
         child: Column(
           children: [
             // Image.asset(AppAssets.body,width: Get.width,), // Add your body diagram image here
             DataBox(
                 title: 'Girth',
                 name: provider.shoulder,
                 desc: AppString.girth_text,
                 press: (){
                   Get.bottomSheet(MeasurementBottomSheet(id: id, keyName: DbKey.k_shoulder.toString(),));
                 }
             ),
             SizedBox(height: 10.0,),

             DataBox(
                 title: 'Bust/Chest',
                 name: provider.belli,
                 desc: AppString.girth_text,
                 press: (){
                   Get.bottomSheet(MeasurementBottomSheet(id: id, keyName: DbKey.k_belli.toString(),));
                 }
             ),
             SizedBox(height: 10.0,),

             DataBox(
                 title: 'Waist',
                 name: provider.leg,
                 desc: AppString.girth_text,
                 press: (){
                   Get.bottomSheet(MeasurementBottomSheet(id: id, keyName: DbKey.k_leg.toString(),));
                 }
             ),
             SizedBox(height: 10.0,),


             DataBox(
                 title: 'Hips',
                 name: provider.hip,
                 desc: AppString.girth_text,
                 press: (){
                   Get.bottomSheet(MeasurementBottomSheet(id: id, keyName: DbKey.k_hip.toString(),));
                 }
             ),
             SizedBox(height: 10.0,),

             DataBox(
                 title: 'Inseam',
                 name: provider.knee,
                 desc: AppString.girth_text,
                 press: (){
                   Get.bottomSheet(MeasurementBottomSheet(id: id, keyName: DbKey.k_knee.toString(),));
                 }
             ),
             SizedBox(height: 20.0,),


             Align(
               alignment: AlignmentDirectional.bottomEnd,
               child: Column(
                 children: [
                   TextWidget(text: "Last Update", size: 12.0),
                   SizedBox(height: 2.0,),
                   LabelBox(
                     name: provider.lastUpdate,
                   ),
                 ],
               ),
             ),
           ],
         ),
       );
     },
    );
  }
}

class DataBox extends StatelessWidget {
  final String title,name, desc;
  final VoidCallback press;
  const DataBox({super.key, required this.title, required this.name, required this.desc, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(text: title, size: 18.0,isBold: true,),
              SizedBox(width: 10.0,),
              LabelBox(
                name: name,
              ),
            ],
          ),
          TextWidget(text: desc, size: 10.0),
        ],
      ),
    );
  }
}


class LabelBox extends StatelessWidget {
  final String name;
  const LabelBox({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextWidget(text: name,size: 12.0,color: Colors.black,maxLine: 2,),
      ),
    );
  }
}
