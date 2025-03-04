import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/provider/user/user_provider.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:mom_dance/screen/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../res/appAsset/app_assets.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context,listen: false).fetchBannerImages();
    Timer(const Duration(seconds: 4),(){
      if(auth.currentUser !=null ){
        Get.offAllNamed(RoutesName.homeScreen);
      }else{
        Get.offAllNamed(RoutesName.loginScreen);
      }

    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(AppIcons.new_splash,width: Get.width / 1.5,),
      ),
    );
  }
}
