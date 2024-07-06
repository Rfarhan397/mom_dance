import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/screen/countdown/count_down_screen.dart';
import 'package:provider/provider.dart';

import '../provider/countdown/countdown_provider.dart';
class CountdownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pv = Provider.of<CountdownProvider>(context,listen: false);
    pv.fetchInitialCountdown();
    // final duration = countdownProvider.countdownDuration;
    //
    // final days = duration.inDays;
    // final hours = duration.inHours % 24;
    // final minutes = duration.inMinutes % 60;
    // final seconds = duration.inSeconds % 60;
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: 'Countdown to next Competition', size: 12.0,color: primaryColor,),
                SizedBox(width: 10.0,),
                GestureDetector(
                    onTap: (){
                      Get.to(SetCountdownScreen());
                    },
                    child: Icon(Icons.edit,color: primaryColor,))
              ],
            ),
            SizedBox(height: 10),
            Consumer<CountdownProvider>(
              builder: (context, countdownProvider, child) {
                String formatDigit(int digit) {
                  return digit.toString().padLeft(2, '0');
                }
                final duration = countdownProvider.countdownDuration;
                final months = countdownProvider.countdownDuration.inDays ~/ 30;
                final days = duration.inDays;
                final hours = duration.inHours % 24;
                final minutes = duration.inMinutes % 60;
                final seconds = duration.inSeconds % 60;


                log("Months: $months: $days: $hours: $minutes: $seconds");

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


class CountdownDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountdownProvider>(context);
    final duration = countdownProvider.countdownDuration;

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$days Days, $hours Hours, $minutes Minutes, $seconds Seconds',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            // For testing: setting the countdown to 1 minute from now
            DateTime endTime = DateTime.now().add(Duration(minutes: 1));
            await countdownProvider.setCountdownTimestamp(endTime);
          },
          child: Text('Start 1 Minute Countdown'),
        ),
      ],
    );
  }
}
