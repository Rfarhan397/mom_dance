import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/helper/button_widget.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/services/musicLibrary/music_library_services.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/image_loader_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/constant/value_provider.dart';
import '../../provider/image/image_provider.dart';
import '../../res/appIcon/app_icons.dart';

class MusiclibraryBottomSheet extends StatelessWidget {
  String id,image,link,name,type;
  MusiclibraryBottomSheet({super.key,
    this.id = '',
    this.image = '',
    this.link = '',
    this.name = '',
    this.type = 'new'
  });

  var nameController = TextEditingController();
  var musicUrlController = TextEditingController();



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
            TextWidget(text: "Add Music Library", size: 16.0,color: Colors.white,isBold: true,),
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
            TextWidget(text: "Dancer Name", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? nameController.text = name  : "name", controller: nameController),

            SizedBox(height: 20.0,),
            TextWidget(text: "Music Url", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            CustomTextField(hintText: type == "edit" ? musicUrlController.text = link  : "music url", controller: musicUrlController),

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
                      final musicLibrary = MusicLibraryModel(
                        id: autoID(),
                        image: downloadUrl.toString(),
                        userUID: auth.currentUser!.uid.toString(),
                        name: nameController.text.toString().trim(),
                        musicUrl: musicUrlController.text.toString().trim(),
                      );
                      await MusicLibraryServices().addMusicLibrary(musicLibrary, context);
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
                    final musicLibrary = MusicLibraryModel(
                      id: id,
                      image: downloadUrl.toString(),
                      userUID: auth.currentUser!.uid.toString(),
                      name: nameController.text.toString().trim(),
                      musicUrl: musicUrlController.text.toString().trim(),
                    );
                    await MusicLibraryServices().updateMusicLibrary(musicLibrary, context);
                  }

                  nameController.text = "";
                  musicUrlController.text = "";
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
