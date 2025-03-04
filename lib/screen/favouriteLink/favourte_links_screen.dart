import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/compSchedule/comp_schedule_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/favouriteLink/favourite_links_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/model/favouriteLink/favourite_links_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:mom_dance/services/favouriteLink/favourite_links_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../provider/dancer/dancer_provider.dart';

class FavourteLinksScreen extends StatelessWidget {
  FavourteLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SimpleHeader(text: "Favorite Links"),
              const SizedBox(height: 20.0,),

              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<FavouriteLinksModel>>(
                    stream: productProvider.getFavouriteLinks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Favorite Links found'));
                      }

                      List<FavouriteLinksModel> links = snapshot.data!;
                      return ListView.builder(
                        itemCount: links.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FavouriteLinksModel model = links[index];
                          return  GestureDetector(
                            onTap: (){

                              showCustomDialog(
                                  isThird: false,
                                  isSecond: true,
                                  onDelete: () async{
                                    await  FavouriteLinksServices().deleteFavouriteLinks(model.id, context);
                                    Get.back();
                                  }, onDetails: (){}, onEdit: (){
                                    Navigator.pop(context);
                                    Get.bottomSheet(FavouriteLinksBottomSheet(
                                      id: model.id,
                                      name: model.name,
                                      link: model.link,
                                      type: 'edit',
                                    ));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey.shade300,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(text: model.name, size: 14.0,isBold: true,color: Colors.black,),
                                  const SizedBox(height: 5.0,),
                                  TextWidget(text: model.link, size: 12.0,maxLine: 1,),
                                  GestureDetector(
                                    onTap: () async{
                                     launchWebUrl(url: "https://${model.link}");
                                    },
                                    child: const Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Icon(Icons.link_outlined),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(FavouriteLinksBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  // Future<void> _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri)) {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> launchWebUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}




