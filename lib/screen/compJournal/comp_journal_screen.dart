import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/provider/user/user_provider.dart';
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
   final provider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SimpleHeader(text: "Competition Journal"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.compJournal.toString(),),
                ),
              ),
              const SizedBox(height: 20.0,),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: gradientColor
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Date", size: 12.0,color: Colors.white,)),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Competition", size: 12.0,color: Colors.white)),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Dance", size: 12.0,color: Colors.white)),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Adjudication",color: Colors.white, size: 12.0,maxLine: 1 ,)),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Overall", color: Colors.white,size: 12.0)),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                child: TextWidget(text: "Specialty Award",color: Colors.white, size: 12.0)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Consumer<DancerProvider>(
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.date, size: 12.0,color: Colors.black,)),
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.comp, size: 12.0,color: Colors.black)),
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.dance, size: 12.0,color: Colors.black)),
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.adjuction,color: Colors.black, size: 12.0)),
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.overAll, color: Colors.black,size: 12.0)),
                                        Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextWidget(text: model.special,color: Colors.black, size: 12.0)),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
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




