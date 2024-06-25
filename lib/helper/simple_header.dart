import 'package:flutter/material.dart';
import 'package:mom_dance/helper/back_button.dart';
import 'package:mom_dance/helper/text_widget.dart';
class SimpleHeader extends StatelessWidget {
  final String text;
  const SimpleHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButtonWidget(),
          TextWidget(text: text, size: 14.0,isBold: true),
          TextWidget(text: "", size: 14.0),
        ],
      ),
    );
  }
}
