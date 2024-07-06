import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../helper/button_widget.dart';
import '../../provider/countdown/countdown_provider.dart';

class SetCountdownScreen extends StatefulWidget {
  @override
  _SetCountdownScreenState createState() => _SetCountdownScreenState();
}

class _SetCountdownScreenState extends State<SetCountdownScreen> {
  DateTime? selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Countdown Timer'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedDateTime != null)
              Text(
                'Selected End Time: ${selectedDateTime.toString()}',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            ButtonWidget(text: "Select End Time", onClicked: (){
              _selectDateTime(context);
            }, width: 300.0, height: 50.0),

            SizedBox(height: 20),
            ButtonWidget(text: "Set Countdown",
                onClicked: (){
                  if(selectedDateTime !=null){
                    context.read<CountdownProvider>().setCountdownTimestamp(selectedDateTime!);
                    Navigator.pop(context);
                  }
                },
                width: 300.0, height: 50.0),



          ],
        ),
      ),
    );
  }
}
