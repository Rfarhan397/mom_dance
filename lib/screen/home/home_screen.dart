import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/helper/countdown_class.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/provider/user/user_provider.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/res/appString/app_string.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/menu_card.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context,listen: false).fetchUserProfile();
    Provider.of<UserProvider>(context,listen: false).fetchBannerImages();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child:

                      ButtonWidget(text: "Logout", width: 90.0,height: 40.0,onClicked: (){
                        customDialog(onClick: (){
                          logout();
                        }, title: "Logout", content: "are you sure to logout account");

                      },),
                ),
                const SizedBox(height: 10.0,),
                Image.asset(AppAssets.logo,width: Get.width,height: Get.width/2.5,),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        if (userProvider.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(text: "Hello, ${userProvider.name.toString()}", size: 22.0,),
                            ],
                          ),
                        );
                      },
                    ),


                  ],
                ),

                Consumer<UserProvider>(
                 builder: (context, provider, child){

                   return Container(
                     padding: EdgeInsets.all(20.0),
                     decoration: BoxDecoration(
                       gradient: gradientColor,
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     child: Center(child: TextWidget(text: provider.homeText.toString(),size: 18.0,color: Colors.white,textAlignment: TextAlign.center,)),
                   );
                 },
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
                      title: 'Comp Schedules',
                      press: () {
                        Get.toNamed(RoutesName.compSchedule);
                      },
                    ),
                    MenuCard(
                      image: AppIcons.ic_travel,
                      title: 'Travel Details',
                      press: () {
                        Get.toNamed(RoutesName.travelDetailsScreen);
                      },
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
                      press: () {
                        Get.toNamed(RoutesName.musicLibraryScreen);
                      },
                    ),
                    MenuCard(
                      image: AppIcons.ic_links,
                      title: 'Favorite Links',
                      press: () {
                        Get.toNamed(RoutesName.favouriteScreen);
                      },
                    ),
                    MenuCard(
                      image: AppIcons.ic_album,
                      title: 'Dance Album',
                      press: () {
                        Get.toNamed(RoutesName.danceAlbumScreen);
                      },
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
                      press: () {
                        Get.toNamed(RoutesName.compPackingScreen);
                      },
                    ),
                    MenuCard(
                      image: AppIcons.ic_offer,
                      title: 'Special Offers',
                      press: () {
                        launchWebUrl(url: 'https://www.dancemomlife.com/');
                        },
                    ),
                    MenuCard(
                      image: AppIcons.ic_web,
                      title: 'DanceMomLife.com',
                      press: () {
                        launchWebUrl(url: 'https://www.dancemomlife.com/');
                      },
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
  Future<void> launchWebUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
