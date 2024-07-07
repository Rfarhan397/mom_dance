import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/routes/routes_name.dart';

import '../../model/dancer/dancer_model.dart';
class AddDancerDetailsScreen extends StatelessWidget {
  const AddDancerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final dancer = DancerModel.fromMap(arguments['dancer']);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
            children: [

              SimpleHeader(text: dancer.name.toString()),
              SizedBox(height: 20.0,),
              Container(
                width: Get.width,
                height: Get.width / 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ImageLoaderWidget(imageUrl: dancer.image),
                ),
              ),
             const SizedBox(height: 20.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 CompJournalCard(
                   image: AppAssets.comp_journal,
                   title: 'Competition Journal',
                   press: () {
                     log("Id: ${dancer.id}");
                     Get.toNamed(RoutesName.compJournalScreen,arguments: {
                       "id" : dancer.id
                     });
                   },
                 ),
                 CompJournalCard(
                   image: AppAssets.costume_checklist,
                   title: 'Costume Checklist',
                   press: () {
                     log("Id: ${dancer.id}");
                     Get.toNamed(RoutesName.costumeChecklist,arguments: {
                       "id" : dancer.id
                     });
                   },
                 ),
               ],
             ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CompJournalCard(
                    image: AppAssets.skill_goal,
                    title: 'Skill Goals',
                    press: () {
                      Get.toNamed(RoutesName.skillGoalScreen,arguments: {
                        "id" : dancer.id
                      });
                    },
                  ),
                  CompJournalCard(
                    image: AppAssets.costume_measurement,
                    title: 'Costume Measurements',
                    press: () {
                      log("Id: ${dancer.id}");
                      Get.toNamed(RoutesName.measurementScreen,arguments: {
                        "id" : dancer.id
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CompJournalCard(
                    image: AppAssets.dance_shoes,
                    title: 'Dance Shoes',
                    press: () {
                      log("Id: ${dancer.id}");
                      Get.toNamed(RoutesName.danceShoesScreen,arguments: {
                        "id" : dancer.id
                      });
                    },
                  ),
                  CompJournalCard(
                    image: AppAssets.glass_schedule,
                    title: 'Class Schedule',
                    press: () {
                      log("Id: ${dancer.id}");
                      Get.toNamed(RoutesName.classSchedule,arguments: {
                        "id" : dancer.id
                      });
                    },
                  ),
                ],
              ),

              // const SizedBox(height: 20.0,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     CompJournalCard(
              //       image: AppAssets.choreography_videos,
              //       title: 'Choreography Videos ',
              //       press: () {  },
              //     ),
              //     CompJournalCard(
              //       image: AppAssets.dance_video,
              //       title: 'Dance Videos',
              //       press: () {  },
              //     ),
              //   ],
              // ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompJournalCard extends StatelessWidget {
  final String image, title;
  final VoidCallback press;

  const CompJournalCard({super.key, required this.image, required this.title, required this.press});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width * 0.40,
        height: Get.width * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:  gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                height: Get.width * 0.50 - 50,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextWidget(text: title,size: 12.0,color: Colors.white,)
            ),
          ],
        ),
      ),
    );
  }
}
