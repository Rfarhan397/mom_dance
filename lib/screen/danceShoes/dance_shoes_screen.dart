import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/danceShoes/dance_shoes_bottom_sheet.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/danceShoes/dance_shoes_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/image_loader_widget.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';

class DanceShoesScreen extends StatelessWidget {
  DanceShoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final arguments = Get.arguments as Map<String, dynamic>? ?? {};
   final provider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SimpleHeader(text: "Dance Shoes"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.danceShoes.toString(),),
                ),
              ),
              const SizedBox(height: 20.0,),
              Table(
                border: TableBorder.all(width: 1.0,color: Colors.black),
                columnWidths: const{
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
                          child: Center(child: TextWidget(text: "Dance Genre",color: Colors.white, size: 12.0,maxLine: 1 ,))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Brand/Style", color: Colors.white,size: 12.0))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Color",color: Colors.white, size: 12.0))),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: gradientColor
                          ),
                          child: Center(child: TextWidget(text: "Size",color: Colors.white, size: 12.0))),
                    ]
                  )
                ],
              ),
              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<DanceShoesModel>>(
                    stream: productProvider.getDanceShoes(dancerID: arguments['id'] ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Dance Shoes found'));
                      }

                      List<DanceShoesModel> danceShoes = snapshot.data!;
                      return ListView.builder(
                        itemCount: danceShoes.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DanceShoesModel model = danceShoes[index];
                          return  GestureDetector(
                            onTap: (){
                              showCustomDialog(
                                  isThird: false,
                                  isSecond: true,
                                  onDelete: () async{
                                    await  DanceShoesServices().deleteDanceShoes(model.id, context,model.dancerId);
                                    Get.back();
                                  }, onDetails: (){}, onEdit: (){
                                Navigator.pop(context);
                                Get.bottomSheet(DanceShoesBottomSheet(
                                  id: model.id,
                                  dancerID: model.dancerId,
                                  size: model.size,
                                  shoes: model.shoes,
                                  brand: model.brand,
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
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.shoes,color: Colors.black, size: 10.0))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.brand, color: Colors.black,size: 10.0))),
                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.size,color: Colors.black, size: 10.0))),

                                      Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(child: TextWidget(text: model.color,color: Colors.black, size: 10.0))),
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
          Get.bottomSheet(DanceShoesBottomSheet(id: arguments['id'] ?? "null",));
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}




