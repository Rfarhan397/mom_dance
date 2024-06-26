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
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
import '../../res/appIcon/app_icons.dart';
class CostumeChecklistBottomSheet extends StatelessWidget {
  final String id;
  CostumeChecklistBottomSheet({super.key, required this.id});

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
            TextWidget(text: "Add Constume Checklist", size: 16.0,color: Colors.white,isBold: true,),
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
                    Image.asset(
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
            CustomTextField(hintText: "Dance", controller: daceController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Accesspries", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "Accesspries", controller: accesspriesController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Costume", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "costume", controller: constumeController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Shoes", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: "shoes", controller: shoesController),

            SizedBox(height: 40.0,),
            SimpleButtonWidget(text: "Add", onClicked: () async{


              final costumes = CostumeChecklistModel(
                  id: autoID(),
                  date: dateController.text.toString().trim(),
                  image: "",
                  dancerId: id,
                  userUID: auth.currentUser!.uid.toString(),
                  dance: daceController.text.toString().trim(),
                  accesspries: accesspriesController.text.toString().trim(),
                  shoes: shoesController.text.toString().trim(),
                  costume: constumeController.text.toString().trim()
              );

             await CostumeChecklistServices().addCostumeChecklist(costumes, context, id);
             dateController.text = "";
              accesspriesController.text = "";
             daceController.text = "";
              shoesController.text = "";
              constumeController.text = "";

            }, width: Get.width, height: 50.0),

            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return provider.isLoading == false  ?
                ButtonWidget(
                    text: "Add", onClicked: () async{

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
                  dateController.text = "";
                  accesspriesController.text = "";
                  daceController.text = "";
                  shoesController.text = "";
                  constumeController.text = "";
                  imageProvider.clear();
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
