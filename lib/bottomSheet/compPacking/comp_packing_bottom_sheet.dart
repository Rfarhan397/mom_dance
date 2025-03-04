import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/model/compPacking/comp_packing_model.dart';
import 'package:mom_dance/services/favouriteLink/favourite_links_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/compPacking/packing_provider.dart';

class CompPackingBottomSheet extends StatelessWidget {
  String name,type,packID;
  CompPackingBottomSheet({super.key,
  this.name = '',
  this.packID = '',
  this.type = 'new',
  });

  var nameController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: "Add Competition Packing Item", size: 16.0,color: Colors.white,),

            const SizedBox(height: 20.0,),
            TextWidget(text: "Item", size: 14.0,color: Colors.white,),
            const SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? nameController.text = name : "item", controller: nameController),
            const SizedBox(height: 40.0,),
            SimpleButtonWidget(text: type == "edit" ? "Update" : "Add", onClicked: () async{

              final compPacking = CompPackingModel(
                  id: type == "edit" ? packID : autoID(),
                  name: nameController.text.toString().trim(),
                  userUID: auth.currentUser!.uid.toString(),
              );
              if(type == "edit"){
                await FavouriteLinksServices().updateCompPacking(compPacking, context);
              }else{
                await Provider.of<PackingProvider>(context, listen: false)
                    .addCompPacking(compPacking);
                await FavouriteLinksServices().addCompPacking(compPacking, context);
              }

              nameController.text = "";
              Get.back();
            }, width: Get.width, height: 50.0),
            const SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
