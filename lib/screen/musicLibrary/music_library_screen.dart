import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/bottomSheet/comp/comp_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/constumeChecklist/costume_checklist_bottom_sheet.dart';
import 'package:mom_dance/bottomSheet/musicLibrary/musicLibrary_bottom_sheet.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
import 'package:mom_dance/helper/simple_header.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/musicLibrary/music_library_model.dart';
import 'package:mom_dance/res/appAsset/app_assets.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
import 'package:mom_dance/services/musicLibrary/music_library_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../model/constumeChecklist/costume_checklist_model.dart';
import '../../provider/dancer/dancer_provider.dart';
import '../../provider/user/user_provider.dart';
import '../../res/components/custom_tooltip.dart';

class MusicLibraryScreen extends StatelessWidget {

  MusicLibraryScreen({super.key,
  });

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SimpleHeader(text: "Add Music"),
              Container(
               width: Get.width,
                height: Get.width * 0.450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: ImageLoaderWidget(imageUrl: provider.musicLibrary.toString(),),
                ),
              ),
             const SizedBox(height: 20.0,),

              Consumer<DancerProvider>(
                builder: (context, productProvider, child) {
                  return StreamBuilder<List<MusicLibraryModel>>(
                    stream: productProvider.getMusicLibrary(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Container(
                          height: 50,
                          child: CustomTooltip(
                            message: 'Load your dance music to a third-party storage platform, such as Dropbox, Google Drive, or OneDrive, and paste the link here.',
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(Icons.question_mark,size: 18,),
                            ),
                           ),
                        ));
                      }

                      List<MusicLibraryModel> musicLibrary = snapshot.data!;
                      return ListView.builder(
                        itemCount: musicLibrary.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          MusicLibraryModel model = musicLibrary[index];
                          return  MusicCard(url: model.image, name: model.name, musicUrl: model.musicUrl, id: model.id,);
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
          Get.bottomSheet(MusiclibraryBottomSheet());
        },
        tooltip: 'Increment',
        backgroundColor: primaryColor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}

class MusicCard extends StatelessWidget {
  final String url,name,musicUrl,id;

  const MusicCard({super.key,required this.url, required this.name, required this.musicUrl, required this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       showCustomDialog(onDelete: () async{
         await MusicLibraryServices().deleteMusicLibrary(id, context);
         Get.back();
       },
           onDetails: (){
         log("message $musicUrl");
             launchWebUrl(url: musicUrl);
           },
           isThird: true,
           secondText: "Edit",
           onEdit: (){
         Navigator.pop(context);
             Get.bottomSheet(MusiclibraryBottomSheet(
               id: id,
               image: url,
               link: musicUrl,
               name: name,
               type: 'edit',
             ));
           }
       );
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: ImageLoaderWidget(imageUrl: url,)),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: name, size: 16.0),
                TextWidget(text: "Music", size: 12.0,color: Colors.grey.shade700,),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.play_arrow,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> launchWebUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}




