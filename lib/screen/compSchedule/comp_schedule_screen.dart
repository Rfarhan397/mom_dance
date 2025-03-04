import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/compSchedule/comp_schedule_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../helper/image_loader_widget.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';

class CompScheduleScreen extends StatelessWidget {
  CompScheduleScreen({super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SimpleHeader(text: "Competition Schedule"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.compSchedule.toString(),),
                ),
              ),
              const SizedBox(height: 20.0,),
              Table(
                border: TableBorder.all(width: 1.0,color: Colors.black),
                columnWidths: const {
                  0 : const FlexColumnWidth(1),
                  1 : const FlexColumnWidth(1),
                  2 : const FlexColumnWidth(1),
                  3 : const FlexColumnWidth(1),
                  4 : const FlexColumnWidth(1),
                  5 : const FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Competition", size: 12.0,color: Colors.white,))),
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Date", size: 12.0,color: Colors.white))),
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Location", size: 12.0,color: Colors.white))),

                    //   Container(
                    //       padding: EdgeInsets.all(5.0),
                    //       decoration: BoxDecoration(
                    //           gradient: gradientColor
                    //       ),
                    //       child: Center(child: TextWidget(text: "PDF", size: 12.0,color: Colors.white))),
                    ]
                  )
                ],
              ),
              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<CompScheduleModel>>(
                    stream: productProvider.getCompSchedule(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Competition Schedule found'));
                      }
                      List<CompScheduleModel> compSchedule = snapshot.data!;
                      return ListView.builder(
                        itemCount: compSchedule.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                         CompScheduleModel model = compSchedule[index];
                         log("message${model.date}");
                          return  GestureDetector(
                            onTap: (){

                              showCustomDialog(
                                  isThird: false,
                                  isSecond: true,
                                  onDelete: () async{
                              await  CompJournalServices().deleteCompSchedule(model.id, context);
                              Get.back();
                              }, onDetails: (){}, onEdit: (){
                                Get.bottomSheet(CompScheduleBottomSheet(
                                  type: "edit",
                                  id: model.id,
                                  competition: model.comp,
                                  location: model.location,
                                  date: model.date,
                                ));
                              });
                            },
                            child: Table(
                              border: TableBorder.all(width: 1.0,color: Colors.black),
                              columnWidths: {
                                0 : const FlexColumnWidth(1),
                                1 : const FlexColumnWidth(1),
                                2 : const FlexColumnWidth(1),
                                3 : const FlexColumnWidth(1),
                                4 : const FlexColumnWidth(1),
                                // 5 : FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.comp, size: 10.0,color: Colors.black,))),
                                      Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.date, size: 10.0,color: Colors.black))),
                                      Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.location, size: 10.0,color: Colors.black))),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     launchWebUrl(url: model.pdfUrl);
                                      //   },
                                      //   child: Container(
                                      //       padding: EdgeInsets.all(5.0),
                                      //       child: Center(child: TextWidget(text: "Open Pdf", size: 10.0,color: Colors.black))),
                                      // ),
                                    ]
                                )
                              ],
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
          Get.bottomSheet(CompScheduleBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: const Icon(Icons.add,color: Colors.white,),
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




