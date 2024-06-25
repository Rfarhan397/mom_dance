import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/text_widget.dart';
class SubscriptionCard extends StatelessWidget {
  final String price, planName, planDesc;
   bool isTick;

   SubscriptionCard({super.key,
    required this.price, required this.planName, required this.planDesc, this.isTick = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.420,
      height: Get.width * 0.480,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1.0,color: Colors.white.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(Get.width * 0.056),
      ),
      padding: EdgeInsets.all(Get.width * 0.026),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextWidget(text: planName,isBold: true,size: 20.0,color: Colors.white,)
          ),
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.check_circle,
              color: isTick ? Colors.red  : Colors.grey,
              size: 24,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextWidget(text: '\$$price',isBold: true,size: 36.0,color: Colors.white,)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextWidget(text: planDesc,size: 16.0,color: Colors.white,)
          ),
        ],
      ),
    );
  }
}