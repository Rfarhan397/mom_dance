import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constant.dart';
import '../../../helper/text_widget.dart';
class WeeksWidget extends StatelessWidget {
  final String weekName, value;
  const WeeksWidget({super.key, required this.weekName, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          padding : EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: Colors.black,width: 1.0)
          ),
          child: TextWidget(text: weekName,size: 12.0,),
        ),

        Container(
          width: Get.width,
          padding : EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black,width: 1.0)
          ),
          child: TextWidget(text: value,size: 12.0,),
        ),
      ],
    );
  }
}
