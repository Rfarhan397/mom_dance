import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:mom_dance/services/costumeChecklist/costume_checklist_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/image_loader_widget.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
import '../../res/appIcon/app_icons.dart';
class CostumeChecklistBottomSheet extends StatelessWidget {
  final String id;
  String image,dancerID,dance,costume,accesspries,shoes,type;
  CostumeChecklistBottomSheet({super.key, required this.id,
  this.image = '',
  this.dancerID = '',
  this.dance = '',
  this.costume = '',
  this.accesspries = '',
  this.shoes = '',
  this.type = 'new',
  });

  var dateController = TextEditingController();
  var daceController = TextEditingController();
  var accesspriesController = TextEditingController();
  var constumeController = TextEditingController();
  var shoesController = TextEditingController();



   @override
  Widget build(BuildContext context) {
     final imageProvider = Provider.of<ImagePickProvider>(context,listen: false);
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
            TextWidget(text: type == "edit" ?  "Update Constume Checklist" : "Add Constume Checklist", size: 16.0,color: Colors.white,isBold: true,),
            SizedBox(height: 20.0,),

            Consumer<ImagePickProvider>(
              builder: (context,provider, child){
                return GestureDetector(
                  onTap: (){
                    provider.pickDancerImage();
                  },
                  child: Container(
                    width: Get.width,
                    height: 200.0,
                    padding: EdgeInsets.all(provider.imageFile !=null ? 5.0 : 30.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:  provider.imageFile !=null ? Image.file(provider.imageFile!,fit: BoxFit.contain,) :
                    type == "edit" ? ImageLoaderWidget(imageUrl: image) : Image.asset(
                      AppIcons.ic_upload,
                      color: primaryColor,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20.0,),
            TextWidget(text: "Dance", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:  type == "edit" ? daceController.text = dance : "Dance", controller: daceController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Accesspries", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? accesspriesController.text = accesspries :  "Accesspries", controller: accesspriesController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Costume", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? constumeController.text = costume :  "costume", controller: constumeController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Shoes", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? shoesController.text = shoes : "shoes", controller: shoesController),

            SizedBox(height: 40.0,),

            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return provider.isLoading == false  ?
                ButtonWidget(
                    text: type == "edit" ? "Update" : "Add", onClicked: () async{

                  provider.setLoading(true);



                  if(type != "edit"){
                    if(imageProvider.imageFile !=null){
                      provider.setLoading(true);
                      final downloadUrl = await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                      final costumes = CostumeChecklistModel(
                          id: autoID(),
                          date: dateController.text.toString().trim(),
                          image: downloadUrl.toString(),
                          dancerId: id,
                          userUID: auth.currentUser!.uid.toString(),
                          dance: daceController.text.toString().trim(),
                          accesspries: accesspriesController.text.toString().trim(),
                          shoes: shoesController.text.toString().trim(),
                          costume: constumeController.text.toString().trim()
                      );

                      await CostumeChecklistServices().addCostumeChecklist(costumes, context, id);
                    }else{
                      showSnackBar(title: "Image Required", subtitle: "");
                    }
                  } else{
                    String? downloadUrl;
                    if(imageProvider.imageFile != null){
                      downloadUrl = await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                    }else{
                      downloadUrl = image;
                    }
                    final costumes = CostumeChecklistModel(
                        id: id,
                        date: dateController.text.toString().trim(),
                        image: downloadUrl.toString(),
                        dancerId: dancerID,
                        userUID: auth.currentUser!.uid.toString(),
                        dance: daceController.text.toString().trim(),
                        accesspries: accesspriesController.text.toString().trim(),
                        shoes: shoesController.text.toString().trim(),
                        costume: constumeController.text.toString().trim()
                    );

                    await CostumeChecklistServices().updateCostumeChecklist(costumes, context, id);
                  }


                  dateController.text = "";
                  accesspriesController.text = "";
                  daceController.text = "";
                  shoesController.text = "";
                  constumeController.text = "";
                  imageProvider.clear();
                  Get.back();
                }, width: Get.width, height: 50.0) :
                ButtonLoadingWidget(
                    loadingMesasge: "saving",
                    width: Get.width,
                    height: 50.0
                );
              },
            ),
            SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
