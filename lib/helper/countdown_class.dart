import 'package:flutter/material.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/countdown/countdown_provider.dart';
class CountdownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: 'Countdown to next Comp', size: 12.0,color: primaryColor,),
            SizedBox(height: 10),
            Consumer<CountdownProvider>(
              builder: (context, countdownProvider, child) {
                String formatDigit(int digit) {
                  return digit.toString().padLeft(2, '0');
                }

                int months = countdownProvider.countdownDuration.inDays ~/ 30;
                int days = countdownProvider.countdownDuration.inDays % 30;
                int hours = countdownProvider.countdownDuration.inHours % 24;
                int minutes = countdownProvider.countdownDuration.inMinutes % 60;
                int seconds = countdownProvider.countdownDuration.inSeconds % 60;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTimeCard('Month', formatDigit(months)),
                    SizedBox(width: 8.0),
                    buildTimeCard('Day', formatDigit(days)),
                    SizedBox(width: 8.0),
                    Text(
                      ':',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    buildTimeCard('Hour', formatDigit(hours)),
                    SizedBox(width: 8.0),
                    buildTimeCard('Minutes', formatDigit(minutes)),
                  ],
                );
              },
            ),
          ],
        );
  }

  Widget buildTimeCard(String label, String value) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextWidget(text: value,size: 22.0,color: Colors.white,)
        ),
        SizedBox(height: 8.0),
        TextWidget(text: label, size: 14.0,color: primaryColor,)
      ],
    );
  }
}