import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';

import '../constant.dart';


class ImageLoaderWidget extends StatelessWidget {
  final String imageUrl;
  const ImageLoaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: primaryColor,)), // Path to your placeholder image
      errorWidget: (context, url, error) => Center(child: Image.asset(AppIcons.new_icon,height: 55,width: 55,)), // Display an error icon if the image fails to load
      fit: BoxFit.cover,
    );
  }
}
