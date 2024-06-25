import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:mom_dance/screen/login/login_screen.dart';
import '../../constant.dart';
import '../../res/appAsset/app_assets.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4),(){
    //  Get.offAllNamed(RoutesName.loginScreen);
      if(auth.currentUser !=null ){
        Get.offAllNamed(RoutesName.homeScreen);
      }else{
        Get.offAllNamed(RoutesName.loginScreen);
      }

    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(AppAssets.logo,width: Get.width / 1.5,),
      ),
    );
  }
}
