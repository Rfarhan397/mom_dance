import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/countdown_class.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/res/appString/app_string.dart';
import 'package:mom_dance/routes/routes_name.dart';

import '../../helper/menu_card.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(AppAssets.logo,width: Get.width,height: Get.width/2.5,),
                SizedBox(height: 20.0,),
                TextWidget(text: "Hello Marine", size: 22.0),
                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: gradientColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(child: TextWidget(text: AppString.home_text,size: 18.0,color: Colors.white,textAlignment: TextAlign.center,)),
                ),
          
                // menu
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuCard(
                      image: AppIcons.ic_dancer,
                      title: 'Dancer',
                      press: (){
                        Get.toNamed(RoutesName.dancerScreen);
                      },
                    ),
                    MenuCard(
                      image: AppIcons.ic_calender,
                      title: 'Comp Schduels',
                      press: () {  },
                    ),
                    MenuCard(
                      image: AppIcons.ic_travel,
                      title: 'Travel Details',
                      press: () {  },
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuCard(
                      image: AppIcons.ic_video,
                      title: 'Music Library',
                      press: () {  },
                    ),
                    MenuCard(
                      image: AppIcons.ic_links,
                      title: 'Favorite Links',
                      press: () {  },
                    ),
                    MenuCard(
                      image: AppIcons.ic_album,
                      title: 'Dance Album',
                      press: () {  },
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuCard(
                      image: AppIcons.ic_list,
                      title: 'Comp Packing List',
                      press: () {  },
                    ),
                    MenuCard(
                      image: AppIcons.ic_offer,
                      title: 'Special Offers',
                      press: () {  },
                    ),
                    MenuCard(
                      image: AppIcons.ic_web,
                      title: 'DanceMomLife.com',
                      press: () {  },
                    ),
                  ],
                ),
          
                const SizedBox(height: 20.0,),
                CountdownScreen()
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
