import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constant.dart';
import '../res/appAsset/app_assets.dart';
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradientColor
      ),
      height: Get.width / 1.5,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              AppAssets.login_bg, // Replace with your image asset
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            color: Colors.red.withOpacity(0.5), // Overlay color with opacity
          ),
        ],
      ),
    );
  }
}
