import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Get.back();
      },
      child: Image.asset(AppIcons.ic_back,width: 25.0,height: 25.0,),
    );
  }
}
