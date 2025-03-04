import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/compSchedule/comp_schedule_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/travel/travel_details_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/compSchedule/comp_schedule_model.dart.dart';
import 'package:mom_dance/model/travelDetails/travel_details_model.dart.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/screen/image_view_screen.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:mom_dance/services/travelDetails/travel_details_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';

class TravelDetailsScreen extends StatelessWidget {
  TravelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SimpleHeader(text: "Travel Details"),
                Container(
                  width: Get.width,
                  height: Get.width * 0.450,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: ImageLoaderWidget(
                      imageUrl: provider.travelDetails.toString(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Consumer<DancerProvider>(
                  builder: (context, productProvider, child) {
                    return StreamBuilder<List<TravelDetailsModel>>(
                      stream: productProvider.getTravelDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),);
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No Travel Details found'));
                        }

                        List<TravelDetailsModel> travels = snapshot.data!;

                        return ListView.builder(
                          itemCount: travels.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            TravelDetailsModel model = travels[index];
                            log("message${model.date}");
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: GestureDetector(
                                    onTap: () {
                                      showCustomDialogBox(
                                          onDelete: () async {
                                            await TravelDetailsServices()
                                                .deleteTravelDetails(
                                                model.id, context);
                                            Navigator.pop(context);
                                          }, onEdit: () {
                                        Navigator.pop(context);
                                        Get.bottomSheet(
                                            TravelDetailsBottomSheet(
                                              id: model.id,
                                              comp: model.comp,
                                              date: model.date,
                                              location: model.location,
                                              image: model.confirmationImage,
                                              registration: model.registration,
                                              hotel: model.hotel,
                                              type: 'edit',
                                            ));
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(gradient: gradientColor),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                            text: "Check-in Date",
                                                            size: 12.0,
                                                            color: Colors.white,
                                                          )),
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                            text: "Check-out Date",
                                                            size: 12.0,
                                                            color: Colors.white,
                                                          )),
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                              text: "Competition",
                                                              size: 12.0,
                                                              color: Colors.white)),
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                              text: "Location",
                                                              size: 12.0,
                                                              color: Colors.white)),
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                              text: "Hotel Info",
                                                              size: 12.0,
                                                              color: Colors.white)),
                                                      Container(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: TextWidget(
                                                              text: "Confirmation #",
                                                              size: 12.0,
                                                              color: Colors.white)),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.date,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )),
                                                    Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.checkOutDate,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )),
                                                    Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.comp,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )),
                                                    Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.location,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )), Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.hotel,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )), Container(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: TextWidget(
                                                          text: model.registration,
                                                          size: 12.0,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                // Table(
                //   border: TableBorder.all(width: 1.0, color: Colors.black),
                //   columnWidths: {
                //     0: FlexColumnWidth(1),
                //     1: FlexColumnWidth(1),
                //     2: FlexColumnWidth(1),
                //     3: FlexColumnWidth(1),
                //     4: FlexColumnWidth(1),
                //     5: FlexColumnWidth(1),
                //   },
                //   children: [
                //     TableRow(children: [
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //             text: "Date",
                //             size: 12.0,
                //             color: Colors.white,
                //           ))),
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //                   text: "Competition",
                //                   size: 12.0,
                //                   color: Colors.white))),
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //                   text: "Location",
                //                   size: 12.0,
                //                   color: Colors.white))),
                //     ])
                //   ],
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                // Table(
                //   border: TableBorder.all(width: 1.0, color: Colors.black),
                //   columnWidths: {
                //     0: FlexColumnWidth(1),
                //     1: FlexColumnWidth(1),
                //     2: FlexColumnWidth(1),
                //     3: FlexColumnWidth(1),
                //     4: FlexColumnWidth(1),
                //     5: FlexColumnWidth(1),
                //   },
                //   children: [
                //     TableRow(children: [
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //                   text: "Hotel",
                //                   size: 12.0,
                //                   color: Colors.white))),
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //                   text: "Confirmation",
                //                   size: 12.0,
                //                   color: Colors.white))),
                //       Container(
                //           padding: EdgeInsets.all(5.0),
                //           decoration: BoxDecoration(gradient: gradientColor),
                //           child: Center(
                //               child: TextWidget(
                //                   text: "Photo",
                //                   size: 12.0,
                //                   color: Colors.white))),
                //     ])
                //   ],
                // ),
                // Consumer<DancerProvider>(
                //   builder: (context, productProvider, child) {
                //     return StreamBuilder<List<TravelDetailsModel>>(
                //       stream: productProvider.getTravelDetails(),
                //       builder: (context, snapshot) {
                //         if (snapshot.connectionState ==
                //             ConnectionState.waiting) {
                //           return Center(child: CircularProgressIndicator());
                //         }
                //         if (snapshot.hasError) {
                //           return Center(
                //               child: Text('Error: ${snapshot.error}'));
                //         }
                //         if (!snapshot.hasData || snapshot.data!.isEmpty) {
                //           return Center(child: Text('No Travel Details found'));
                //         }
                //
                //         List<TravelDetailsModel> travels = snapshot.data!;
                //         return ListView.builder(
                //           itemCount: travels.length,
                //           shrinkWrap: true,
                //           physics: NeverScrollableScrollPhysics(),
                //           itemBuilder: (context, index) {
                //             TravelDetailsModel model = travels[index];
                //             log("message${model.date}");
                //             return GestureDetector(
                //               onTap: () {
                //                 showCustomDialogBox(onDelete: () async {
                //                   await TravelDetailsServices()
                //                       .deleteTravelDetails(model.id, context);
                //                   Navigator.pop(context);
                //                 }, onEdit: () {
                //                   Navigator.pop(context);
                //                   Get.bottomSheet(TravelDetailsBottomSheet(
                //                     id: model.id,
                //                     comp: model.comp,
                //                     date: model.date,
                //                     location: model.location,
                //                     image: model.confirmationImage,
                //                     registration: model.registration,
                //                     hotel: model.hotel,
                //                     type: 'edit',
                //                   ));
                //                 });
                //               },
                //               child: Table(
                //                 border: TableBorder.all(
                //                     width: 1.0, color: Colors.black),
                //                 columnWidths: {
                //                   0: FlexColumnWidth(1),
                //                   1: FlexColumnWidth(1),
                //                   2: FlexColumnWidth(1),
                //                   3: FlexColumnWidth(1),
                //                   4: FlexColumnWidth(1),
                //                   5: FlexColumnWidth(1),
                //                 },
                //                 children: [
                //                   TableRow(children: [
                //                     Container(
                //                         padding: EdgeInsets.all(5.0),
                //                         child: Center(
                //                             child: TextWidget(
                //                                 text: model.hotel,
                //                                 size: 10.0,
                //                                 color: Colors.black))),
                //                     Container(
                //                         padding: EdgeInsets.all(5.0),
                //                         child: Center(
                //                             child: TextWidget(
                //                                 text: model.registration,
                //                                 size: 10.0,
                //                                 color: Colors.black))),
                //                     GestureDetector(
                //                       onTap: () {
                //                         Get.to(ImageViewScreen(
                //                             imageUrl: model.confirmationImage));
                //                       },
                //                       child: Container(
                //                           height: 50.0,
                //                           padding: EdgeInsets.all(5.0),
                //                           child: Center(
                //                               child: ImageLoaderWidget(
                //                             imageUrl: model.confirmationImage,
                //                           ))),
                //                     ),
                //                   ])
                //                 ],
                //               ),
                //             );
                //           },
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(TravelDetailsBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
