import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/helper/back_button.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../../provider/dancer/dancer_provider.dart';
class DancerScreen extends StatelessWidget {
  const DancerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const BackButtonWidget(),
                SizedBox(height: 20.0,),
                TextWidget(text: "Dancers", size: 22.0,color: Colors.black,isBold: true,),
                SizedBox(height: 20.0,),
                TextWidget(text: "Tap to edit or delete dancers", size: 13.0,),
                SizedBox(height: 20.0,),
                Consumer<DancerProvider>(
                  builder: (context, productProvider, child) {
                    return StreamBuilder<List<DancerModel>>(
                      stream: productProvider.getMyDancers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No Dancer found'));
                        }

                        List<DancerModel> daancers = snapshot.data!;
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.9
                          ),
                          itemCount: daancers.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            DancerModel dance = daancers[index];
                            return DancerCard(model: dance,);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutesName.addDancerScreen);
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}

class DancerCard extends StatelessWidget {
  final DancerModel model;

  const DancerCard({super.key,required this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      showCustomDialog(onDelete: () async{
        Get.back();
       await firestore.collection(DbKey.c_dancers).doc(model.id).delete();
       showSnackBar(title: "Dancer Deleted", subtitle: "");
      }, onEdit: (){
        Get.back();
        Get.toNamed(RoutesName.addDancerScreen,arguments: {
          'dancer' : model.toMap(),
          'type' : 'edit'
        });
      }, onDetails: () {
        Get.back();
        Get.toNamed(RoutesName.addDancerDetailsScreen, arguments: {
          'dancer' : model.toMap(),
        });
      });
      },
      child: Stack(
       children: [
         Container(
           // width: Get.width * 0.52, // Adjust the width as needed
           // height: 100.0, // Adjust the height as needed
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
           ),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(20),
             child: ImageLoaderWidget(imageUrl: model.image,),
           ),
         ),
         Container(
           // width: Get.width * 0.52, // Adjust the width as needed
           // height: 100.0, // Adjust the height as needed
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             image: DecorationImage(
               image: NetworkImage(model.image), // Replace with your image path
               fit: BoxFit.cover,
             ),
           ),
           child: Align(
             alignment: Alignment.bottomLeft,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                 model.name,
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 14,
                   fontWeight: FontWeight.bold,
                   //backgroundColor: Colors.black54,
                 ),
               ),
             ),
           ),
         ),
       ],
      ),
    );
  }
}
