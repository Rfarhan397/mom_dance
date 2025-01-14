import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/model/favouriteLink/favourite_links_model.dart';
import 'package:mom_dance/services/favouriteLink/favourite_links_services.dart';
import '../../constant.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';

class FavouriteLinksBottomSheet extends StatelessWidget {
  String id,name,link,type;
  FavouriteLinksBottomSheet({super.key,
  this.id = '',
  this.name = '',
  this.link = '',
  this.type = 'new',
  });

  var nameController = TextEditingController();
  var linkController = TextEditingController();

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
            TextWidget(text: "Add Favorite Link", size: 16.0,color: Colors.white,),

            SizedBox(height: 20.0,),
            TextWidget(text: "Name", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? nameController.text = name : "name", controller: nameController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Link", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? linkController.text = link : "URL", controller: linkController),


            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: type == "edit" ? "Update" : "Add", onClicked: () async{


              final favouriteLinks = FavouriteLinksModel(
                  id: type == "edit" ? id : autoID(),
                  name: nameController.text.toString().trim(),
                  link: linkController.text.toString().trim(),
                  userUID: auth.currentUser!.uid.toString(),
              );

              if(type == "edit"){
                await FavouriteLinksServices().updateFavouriteLinks(favouriteLinks, context);
              }else{
                await FavouriteLinksServices().addFavouriteLinks(favouriteLinks, context);
              }

              nameController.text = "";
              linkController.text = "";
              Get.back();
            }, width: Get.width, height: 50.0),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
