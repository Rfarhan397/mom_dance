import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/constumeChecklist/costume_checklist_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/costumeChecklist/costume_checklist_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../model/constumeChecklist/costume_checklist_model.dart';
import '../../provider/dancer/dancer_provider.dart';

class CostumeChecklistScreen extends StatelessWidget {
  CostumeChecklistScreen({super.key});

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
              SimpleHeader(text: "Costume Checklist"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(AppAssets.costume_checklist,fit: BoxFit.cover,),
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
                          child: Center(child: TextWidget(text: "Photo", size: 10.0,color: Colors.white,))),
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
                          child: Center(child: TextWidget(text: "Costume", size: 10.0,color: Colors.white))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Accesspries",color: Colors.white, size: 10.0,maxLine: 1 ,))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Shoes", color: Colors.white,size: 10.0))),
                    ]
                  )
                ],
              ),
              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<CostumeChecklistModel>>(
                    stream: productProvider.getCostumeChecklist(dancerID: arguments['id'] ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Costume Checklist found'));
                      }

                      List<CostumeChecklistModel> costumes = snapshot.data!;
                      return ListView.builder(
                        itemCount: costumes.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          CostumeChecklistModel model = costumes[index];
                         log("message${model.date}");
                          return  GestureDetector(
                            onTap: (){
                              showCustomDialog(
                                  isThird: false,
                                  isSecond: true,
                                  onDelete: () async{
                                    await  CostumeChecklistServices().deleteCostumeChecklist(model.id, context,model.dancerId);
                                    Get.back();
                                  }, onDetails: (){}, onEdit: (){
                                Navigator.pop(context);
                                Get.bottomSheet(CostumeChecklistBottomSheet(
                                  id: model.id,
                                  image: model.image,
                                  dancerID: model.dancerId,
                                  dance: model.dance,
                                  costume: model.costume,
                                  accesspries: model.accesspries,
                                  shoes: model.shoes,
                                  type: 'edit',
                                ));
                              });
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
                                        width: 100.0,
                                          height: 100.0,
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: ImageLoaderWidget(imageUrl: model.image,))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.dance, size: 10.0,color: Colors.black))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.costume, size: 10.0,color: Colors.black))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.accesspries,color: Colors.black, size: 10.0))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.shoes, color: Colors.black,size: 10.0))),
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
          Get.bottomSheet(CostumeChecklistBottomSheet(id: arguments['id'] ?? "null",));
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}




