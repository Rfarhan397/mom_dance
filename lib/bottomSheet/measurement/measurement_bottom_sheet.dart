import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/provider/measurements/measurement_provider.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
class MeasurementBottomSheet extends StatelessWidget {
  final String id,keyName;
  MeasurementBottomSheet({super.key, required this.id, required this.keyName});

  var detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeasurementProvider>(context,listen: false);
    log("Bottom Sheet: $id $keyName");
    provider.getMeasurement(id: id);
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
            TextWidget(text: "Add Measurements", size: 16.0,color: Colors.white,),
            SizedBox(height: 20.0,),

            SizedBox(height: 20.0,),
            TextWidget(text: "Details", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "add details", controller: detailsController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: "Add", onClicked: () async{

           await provider.saveMeasurements(id: id, key: keyName, value: detailsController.text.toString()..trim());
           provider.getMeasurement(id: id);
           Get.back();

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
