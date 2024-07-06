import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/constumeChecklist/costume_checklist_model.dart';
import 'package:mom_dance/model/travelDetails/travel_details_model.dart.dart';
import 'package:mom_dance/services/compJornal/comp_journal_services.dart';
import 'package:mom_dance/services/costumeChecklist/costume_checklist_services.dart';
import 'package:mom_dance/services/travelDetails/travel_details_services.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/simple_button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
import '../../res/appIcon/app_icons.dart';
class TravelDetailsBottomSheet extends StatelessWidget {
  String date,comp,location,registration,hotel,type,image,id;

  TravelDetailsBottomSheet({super.key,
   this.id = '',
   this.date = '',
   this.comp= '',
   this.location= '',
   this.registration= '',
   this.hotel= '',
   this.image= '',
   this.type= 'new',
  });

  var dateController = TextEditingController();
  var compController = TextEditingController();
  var locationController = TextEditingController();
  var registrationController = TextEditingController();
  var hotelController = TextEditingController();
  DateTime? _selectedDate;


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
            TextWidget(text: "Add Travel Details", size: 16.0,color: Colors.white,isBold: true,),

            SizedBox(height: 20.0,),
            TextWidget(text: "Date", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return CustomTextField(
                    callback: (){
                      selectDateRangeFun(context);
                    },
                    radius: 15.0,
                    hintText: provider.selectedDateRange == null ?
                    type == "edit" ? dateController.text = date  : "Select Date" :
                    dateController.text = "${formatDateRange(provider.selectedDateRange)}",
                    controller: dateController
                );
              },
            ),

            SizedBox(height: 20.0,),
            TextWidget(text: "Comp", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? compController.text = comp  : "comp", controller: compController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Location", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? locationController.text = location  : "location", controller: locationController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Registration", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText:type == "edit" ? registrationController.text = registration  : "registration", controller: registrationController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Hotel", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? hotelController.text = hotel  : "hotel", controller: hotelController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Upload snapshot of confirmation here", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
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

            SizedBox(height: 40.0,),


            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return provider.isLoading == false  ?
                ButtonWidget(
                    text: type == "edit" ? "Update" :"Add", onClicked: () async{

                  provider.setLoading(true);

                  if(type != "edit"){
                    if(imageProvider.imageFile !=null){
                      provider.setLoading(true);
                      final downloadUrl =  await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                      final travelDetails = TravelDetailsModel(
                          id: autoID(),
                          date: dateController.text.toString().trim(),
                          confirmationImage: downloadUrl.toString(),
                          userUID: auth.currentUser!.uid.toString(),
                          location: locationController.text.toString().trim(),
                          registration: registrationController.text.toString().trim(),
                          hotel: hotelController.text.toString().trim(),
                          comp: compController.text.toString().trim()
                      );

                      await TravelDetailsServices().addTravelDetails(travelDetails, context);
                    }else{
                      showSnackBar(title: "Image Required", subtitle: "");
                    }
                  }else{
                    String? downloadUrl;
                    if(imageProvider.imageFile != null){
                      downloadUrl = await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                    }else{
                      downloadUrl = image;
                    }
                    final travelDetails = TravelDetailsModel(
                        id: id,
                        date: dateController.text.toString().trim(),
                        confirmationImage: downloadUrl.toString(),
                        userUID: auth.currentUser!.uid.toString(),
                        location: locationController.text.toString().trim(),
                        registration: registrationController.text.toString().trim(),
                        hotel: hotelController.text.toString().trim(),
                        comp: compController.text.toString().trim()
                    );

                    await TravelDetailsServices().updateTravelDetails(travelDetails, context);
                  }


                  dateController.text = "";
                  locationController.text = "";
                  registrationController.text = "";
                  hotelController.text = "";
                  compController.text = "";

                  imageProvider.clear();
                  Get.back();
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
