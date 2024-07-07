
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/model/compPacking/comp_packing_model.dart';
import 'package:mom_dance/services/favouriteLink/favourite_links_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bottomSheet/compPacking/comp_packing_bottom_sheet.dart';
import '../../constant.dart';
import '../../provider/compPacking/packing_provider.dart';
import '../../provider/dancer/dancer_provider.dart';

class CompPackingScreen extends StatelessWidget {
  CompPackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Provider.of<PackingProvider>(context,listen: false).fetchPackingList();
    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SimpleHeader(text: "Competition Packing List"),
              SizedBox(height: 20.0,),


              Consumer<PackingProvider>(
                builder: (context, provider, _) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 3
                    ),
                    shrinkWrap: true,
                    itemCount: provider.packingList.length,
                    itemBuilder: (context, index) {
                      final item = provider.packingList[index];
                      return  GestureDetector(
                        onTap: (){

                          showCustomDialog(
                              isThird: false,
                              isSecond: true,
                              onDelete: () async{
                                await  FavouriteLinksServices().deleteCompPacking(item.id, context);
                                provider.fetchPackingList();

                              }, onDetails: (){}, onEdit: (){
                            Navigator.pop(context);
                            Get.bottomSheet(CompPackingBottomSheet(
                              name: item.name,
                              packID: item.id,
                              type: 'edit',
                            ));
                          });
                        },
                        child: BrushButton(name: item.name,model: item,),
                      );

                    },
                  );
                },
              ),
              // Consumer<DancerProvider>(
              //   builder: (context, productProvider, child) {
              //     return StreamBuilder<List<CompPackingModel>>(
              //       stream: productProvider.getPacking(),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //         if (snapshot.hasError) {
              //           return Center(child: Text('Error: ${snapshot.error}'));
              //         }
              //         if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //           return Center(child: Text('No Competition packing List found'));
              //         }
              //
              //         List<CompPackingModel> links = snapshot.data!;
              //         return GridView.builder(
              //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2, // Number of columns
              //               crossAxisSpacing: 10.0,
              //               mainAxisSpacing: 10.0,
              //               childAspectRatio: 3
              //           ),
              //           itemCount: links.length,
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //           itemBuilder: (context, index) {
              //             CompPackingModel model = links[index];
              //             return  GestureDetector(
              //               onTap: (){
              //
              //                 showCustomDialog(
              //                     isThird: false,
              //                     isSecond: true,
              //                     onDelete: () async{
              //                       await  FavouriteLinksServices().deleteCompPacking(model.id, context);
              //
              //                     }, onDetails: (){}, onEdit: (){
              //                   Navigator.pop(context);
              //                       Get.bottomSheet(CompPackingBottomSheet(
              //                         name: model.name,
              //                         packID: model.id,
              //                         type: 'edit',
              //                       ));
              //                 });
              //               },
              //               child: BrushButton(name: model.name,model: model,),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(CompPackingBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  Future<void> launchUrl({String? url}) async {
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class BrushButton extends StatelessWidget {
  final String name;
  final CompPackingModel model;

  const BrushButton({super.key, required this.name, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      height: 50, // Adjust the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: gradientColor
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Provider.of<PackingProvider>(context,listen: false).toggleMarking(model);
            },
            child: Container(
              width: 50, // Width of the white box
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                color: Colors.white,
              ),
              child: Icon(Icons.done,color: model.isMarked ? primaryColor : Colors.white,),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Adjust the font size as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




