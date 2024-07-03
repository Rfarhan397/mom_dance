import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/constumeChecklist/costume_checklist_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/danceAlbum/dance_album_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/musicLibrary/musicLibrary_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/danceModel/dance_album_model.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../model/constumeChecklist/costume_checklist_model.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';
import '../../services/danceAlbum/dance_album_services.dart';

class DanceAlbumScreen extends StatelessWidget {
  DanceAlbumScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SimpleHeader(text: "Dance Album"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.danceAlbum.toString(),),
                ),
              ),
             const SizedBox(height: 20.0,),

              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<DanceAlbumModel>>(
                    stream: productProvider.getDanceAlbum(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No dance album found'));
                      }

                      List<DanceAlbumModel> musicLibrary = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.5
                        ),
                        itemCount: musicLibrary.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DanceAlbumModel model = musicLibrary[index];
                          return  GestureDetector(
                            onTap: (){
                              showCustomDialogBox(
                                  onDelete: () async{
                                    await  DanceAlbumServices().deleteDanceAlbum(model.id, context);
                                    Navigator.pop(context);
                                  }, onEdit: (){
                                    Navigator.pop(context);
                                    Get.bottomSheet(DanceAlbumBottomSheet(
                                      id: model.id,
                                      name: model.name,
                                      image: model.image,
                                      type: "edit",
                                    ));
                              }
                              );

                            },
                            child: Container(
                              width: Get.width,
                              child: Column(
                                children: [
                                  Container(
                                      height: 150.0,
                                      child: ImageLoaderWidget(imageUrl: model.image)),
                                  SizedBox(height: 10.0,),
                                  TextWidget(text: model.name, size: 14.0,color: Colors.black,)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(DanceAlbumBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}





