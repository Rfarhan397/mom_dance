import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/services/danceShoes/dance_shoes_services.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';

class DanceShoesBottomSheet extends StatelessWidget {
  final String id;
  String shoesID,type,shoes,brand,size,dancerID;
  DanceShoesBottomSheet({super.key, required this.id,
  this.type = 'new',
  this.shoesID = '',
  this.shoes = '',
  this.brand = '',
  this.size = '',
  this.dancerID = '',
  });

  var shoesController = TextEditingController();
  var brandController = TextEditingController();
  var sizeController = TextEditingController();
  var colorController = TextEditingController();



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
            TextWidget(text: type == "edit"  ? "Update Shoes" : "Add Shoes", size: 16.0,color: Colors.white,),


            SizedBox(height: 20.0,),
            TextWidget(text: "Dance Genre", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit"  ? shoesController.text = shoes : "dance genre", controller: shoesController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Brand / Style", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit"  ? brandController.text = brand : "brand/style", controller: brandController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Color", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit"  ? colorController.text = size : "color", controller: colorController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Size", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit"  ? sizeController.text = size : "size", controller: sizeController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text:  type == "edit" ? "Update": "Add", onClicked: () async{


              final danceShoes = DanceShoesModel(
                  id: type == "edit" ?id : autoID(),
                  dancerId: type == "edit" ? dancerID : id,
                  userUID: auth.currentUser!.uid.toString(),
                  shoes: shoesController.text.toString().trim(),
                  brand: brandController.text.toString().trim(),
                  size: sizeController.text.toString().trim(),
                 color: colorController.text.toString().trim(),

              );

              if(type == "edit"){
                await DanceShoesServices().updateDanceShoes(danceShoes, context, id);
              }else{
                await DanceShoesServices().addDanceShoes(danceShoes, context, id);
              }



              shoesController.text = "";
              brandController.text = "";
              sizeController.text = "";
              Get.back();
            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
