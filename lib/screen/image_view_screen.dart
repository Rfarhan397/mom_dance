import 'package:flutter/material.dart';
import 'package:mom_dance/helper/back_button.dart';
import 'package:mom_dance/helper/image_loader_widget.dart';
class ImageViewScreen extends StatelessWidget {
  final String imageUrl;
  const ImageViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButtonWidget(),

            Center(
              child: ImageLoaderWidget(imageUrl: imageUrl,),
            ),
          ],
        ),
      ),
    );
  }
}
