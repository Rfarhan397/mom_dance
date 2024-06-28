import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../provider/dancer/dancer_provider.dart';

class CompJournalScreen extends StatelessWidget {
   CompJournalScreen({super.key});

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final arguments = Get.arguments as Map<String, dynamic>? ?? {};

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SimpleHeader(text: "Comp Journal"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(AppAssets.comp_journal,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 20.0,),
              Table(
                border: TableBorder.all(width: 1.0,color: Colors.black),
                columnWidths: {
                  0 : FlexColumnWidth(1),
                  1 : FlexColumnWidth(1),
                  2 : FlexColumnWidth(1),
                  3 : FlexColumnWidth(1),
                  4 : FlexColumnWidth(1),
                  5 : FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Date", size: 10.0,color: Colors.white,))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Comp", size: 10.0,color: Colors.white))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Dance", size: 10.0,color: Colors.white))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Adjuction",color: Colors.white, size: 10.0,maxLine: 1 ,))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Overall", color: Colors.white,size: 10.0))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Special",color: Colors.white, size: 10.0))),
                    ]
                  )
                ],
              ),
              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<CompJournalModel>>(
                    stream: productProvider.getCompJournal(dancerID: arguments['id'] ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Comp Journal found'));
                      }

                      List<CompJournalModel> compJournal = snapshot.data!;
                      return ListView.builder(
                        itemCount: compJournal.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                         CompJournalModel model = compJournal[index];
                         log("message${model.date}");
                          return  GestureDetector(
                            onTap: (){
                              showCustomDialog(onDelete: () async{
                                await CompJournalServices().deleteCompJournal(
                                  id: model.id.toString(),
                                  dancerID: model.dancerId.toString(),
                                  context: context
                                );
                               Navigator.pop(context);
                              },
                                  onDetails: (){},
                                  isThird: false,
                                  onEdit: (){
                                    Navigator.pop(context);
                                    Get.bottomSheet(CompBottomSheet(
                                      id: model.id,
                                      comp: model.comp,
                                      dance: model.dance,
                                      adjuction: model.adjuction,
                                      overAll: model.overAll,
                                      special: model.special,
                                      date: model.date,
                                      compID: model.id,
                                      dancerID: model.dancerId,
                                      type: 'edit',
                                    ));
                                  }
                              );

                            },
                            child: Table(
                              border: TableBorder.all(width: 1.0,color: Colors.black),
                              columnWidths: {
                                0 : FlexColumnWidth(1),
                                1 : FlexColumnWidth(1),
                                2 : FlexColumnWidth(1),
                                3 : FlexColumnWidth(1),
                                4 : FlexColumnWidth(1),
                                5 : FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.date, size: 10.0,color: Colors.black,))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.comp, size: 10.0,color: Colors.black))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.dance, size: 10.0,color: Colors.black))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.adjuction,color: Colors.black, size: 10.0))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.overAll, color: Colors.black,size: 10.0))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.special,color: Colors.black, size: 10.0))),
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
          Get.bottomSheet(CompBottomSheet(id: arguments['id'] ?? "null",));
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}




