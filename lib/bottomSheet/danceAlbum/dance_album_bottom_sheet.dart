import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/danceModel/dance_album_model.dart';
import 'package:mom_dance/services/danceAlbum/dance_album_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/image_loader_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
import '../../res/appIcon/app_icons.dart';

class DanceAlbumBottomSheet extends StatelessWidget {
  String id,name,image,type;
  DanceAlbumBottomSheet({super.key,
  this.name = '',
  this.id = '',
  this.image = '',
  this.type = '',
  });

  var nameController = TextEditingController();

   @override
  Widget build(BuildContext context) {
     final imageProvider = Provider.of<ImagePickProvider>(context,listen: false);
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
            TextWidget(text: "Add Dance Album", size: 16.0,color: Colors.white,isBold: true,),
            const SizedBox(height: 20.0,),

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

            const SizedBox(height: 20.0,),
            TextWidget(text: "Name", size: 14.0,color: Colors.white,),
            const SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? nameController.text = name  : "name", controller: nameController),


            const SizedBox(height: 40.0,),

            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return provider.isLoading == false  ?
                ButtonWidget(
                    text:  type == "edit" ? "Update" : "Add", onClicked: () async{

                  provider.setLoading(true);

                  if(type != "edit"){
                    if(imageProvider.imageFile !=null){
                      provider.setLoading(true);
                      final downloadUrl =  await imageProvider.uploadImage(imageFile: imageProvider.imageFile);
                      final danceAlbum = DanceAlbumModel(
                        id: autoID(),
                        image: downloadUrl.toString(),
                        userUID: auth.currentUser!.uid.toString(),
                        name: nameController.text.toString().trim(),
                      );
                      await DanceAlbumServices().addDanceAlbum(danceAlbum, context);
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
                    final danceAlbum = DanceAlbumModel(
                      id: id,
                      image: downloadUrl.toString(),
                      userUID: auth.currentUser!.uid.toString(),
                      name: nameController.text.toString().trim(),
                    );

                    await DanceAlbumServices().updateDanceAlbum(danceAlbum, context);
                  }


                  nameController.text = "";
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
            const SizedBox(height: 40.0,),
          ],
        ),
      ),
    );
  }
}
