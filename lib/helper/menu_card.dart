import 'package:flutter/material.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/res/appIcon/app_icons.dart';
class MenuCard extends StatelessWidget {
  final String image,title;
  final VoidCallback press;
  const MenuCard({super.key, required this.image, required this.title, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: gradientColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image,width: 40.0,height: 40.0,color: Colors.white,),
            ),
          ),
          SizedBox(height: 4.0,),
          TextWidget(text: title, size: 12.0,isBold: true,)
        ],
      ),
    );
  }
}
