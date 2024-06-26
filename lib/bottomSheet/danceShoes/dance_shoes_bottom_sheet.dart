import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/services/danceShoes/dance_shoes_services.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';

class DanceShoesBottomSheet extends StatelessWidget {
  final String id;
  DanceShoesBottomSheet({super.key, required this.id});

  var shoesController = TextEditingController();
  var brandController = TextEditingController();
  var sizeController = TextEditingController();



   @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(20.0),
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
            TextWidget(text: "Add Shoes", size: 16.0,color: Colors.white,),


            SizedBox(height: 20.0,),
            TextWidget(text: "Shoes", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Shoes", controller: shoesController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Brand / Style", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "brand", controller: brandController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Size", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "size", controller: sizeController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: "Add", onClicked: () async{


              final danceShoes = DanceShoesModel(
                  id: autoID(),
                  dancerId: id,
                  userUID: auth.currentUser!.uid.toString(),
                  shoes: shoesController.text.toString().trim(),
                  brand: brandController.text.toString().trim(),
                  size: sizeController.text.toString().trim(),

              );

             await DanceShoesServices().addDanceShoes(danceShoes, context, id);
              shoesController.text = "";
              brandController.text = "";
              sizeController.text = "";

            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
