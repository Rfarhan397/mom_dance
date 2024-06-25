import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
class CustomRichText extends StatelessWidget {
  final String firstText,secondText;
  final VoidCallback press;
  double firstSize,secondSize;
  CustomRichText({super.key,
    required this.firstText,
    required this.secondText,
    required this.press,
    this.firstSize = 12.0,
    this.secondSize = 12.0
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: firstText,
          style:  TextStyle(color: Colors.black,fontSize: firstSize),
          children: <InlineSpan>[
            const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SizedBox(width: 5.0)),
            TextSpan(
              text: secondText,
              style:  TextStyle(color: primaryColor,fontSize: secondSize),
              recognizer: TapGestureRecognizer()
                ..onTap = press,
            ),
          ],
        )
    );
  }
}
