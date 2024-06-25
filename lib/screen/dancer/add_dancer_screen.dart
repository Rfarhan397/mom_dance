import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/back_button.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/helper/custom_textfield.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/provider/dancer/dancer_provider.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:provider/provider.dart';

import '../../helper/button_loading_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
class AddDancerScreen extends StatelessWidget {
   AddDancerScreen({super.key});

  var nameController = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final dancer = DancerModel.fromMap(arguments['dancer']);
    final type = arguments['type']  ?? 'new';
    final imageProvider = Provider.of<ImagePickProvider>(context,listen: false);
    final dancerProvider = Provider.of<DancerProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(),
                  SizedBox(height: 20.0,),
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: TextWidget(text: "Upload Dancer Profile Photo Here", size: 18.0,color: primaryColor,)),
                  SizedBox(height: 20.0,),
                  Consumer<ImagePickProvider>(
                 builder: (context,provider, child){
                   return GestureDetector(
                     onTap: (){
                       provider.pickDancerImage();
                     },
                     child: Container(
                       width: Get.width,
                       height: Get.width / 2,
                       padding: EdgeInsets.all(provider.imageFile !=null ? 5.0 : 30.0),
                       decoration: BoxDecoration(
                         color: Colors.grey.shade300,
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       child:  provider.imageFile !=null ? Image.file(provider.imageFile!,fit: BoxFit.contain,) :
                      type == "edit" ?
                       Image.network(dancer.image) :
                       Image.asset(
                         AppIcons.ic_upload,
                         color: primaryColor,
                       ),
                     ),
                   );
                 },
                  ),
                  SizedBox(height: 20.0,),
                  TextWidget(text: "Dancer Name", size: 14.0),
                  SizedBox(height: 10.0,),
                  CustomTextField(
                      hintText: type == 'edit' ? nameController.text = dancer.name : "Enter dancer Name",
                      controller: nameController
                  ),
                  SizedBox(height: 60.0,),
                  Consumer<ValueProvider>(
                    builder: (context, provider, child){
                      return provider.isLoading == false  ?
                      ButtonWidget(
                          text: "Save", onClicked: () async{
                        if(_key.currentState!.validate()){
                          _key.currentState!.save();

                          if(type != "edit"){
                            if(imageProvider.imageFile !=null){
                              provider.setLoading(true);
                              final downloadUrl = await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                              final autoID = firestore.collection("dancers").doc().id.toString();
                              final dancers = DancerModel(
                                  id: autoID,
                                  name: nameController.text.toString().trim(),
                                  image: downloadUrl.toString(),
                                  userUID: auth.currentUser!.uid.toString()
                              );
                              await dancerProvider.addDancer(dancers,context);

                              nameController.text = "";
                            }else{
                              showSnackBar(title: "Image Required", subtitle: "");
                            }
                          }else{
                            provider.setLoading(true);
                            String? downloadUrl;
                            if(imageProvider.imageFile != null){
                              downloadUrl = await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                            }else{
                              downloadUrl = dancer.image;
                            }
                            final dancers = DancerModel(
                                id: dancer.id,
                                name: nameController.text.toString().trim(),
                                image: downloadUrl.toString(),
                                userUID: auth.currentUser!.uid.toString(),
                              currentDate: dancer.currentDate,
                              currentTime: dancer.currentTime,
                              timestamp: dancer.timestamp
                            );
                            await dancerProvider.updateDancer(dancers,context);
                          }
                        }
                      }, width: Get.width, height: 50.0) :
                      ButtonLoadingWidget(
                          loadingMesasge: "updating",
                          width: Get.width,
                          height: 50.0
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
