import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mom_dance/helper/text_widget.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/routes/routes_name.dart';
import 'package:provider/provider.dart';

const primaryColor = Color(0xffE2222A);
const darkPurple = Color(0xFF7132F5);
const secondaryColor = Color(0xffF38375);
const orangeColor = Color(0xFFE25D6C);
const whiteColor = Color(0xFFFFFFFF);
const lightPink = Color(0xFFC1839F);
const bgColor = Color(0xFFFBF9F9);
const drawerBackground = Color(0xFF212332);
const lightGrey = Color(0xFFE2E8F0);
const darkGrey = Color(0xFF534F5D);
const lightBlue = Colors.lightBlue;
const Color customGrey = Color(0xFFE0E0E0);


LinearGradient gradientColor = const LinearGradient(colors: [

  Color(0xffE2222A),
  Color(0xffF38375),
  // Color(0xff40d5d4),
  // Color(0xff8ae5e5),
  // Color(0xffFFFFFF),
]);

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

String autoID(){
  return FirebaseFirestore.instance.collection("users").doc().id.toString();
}

void showSnackBar({required title, required subtitle}){
  Get.snackbar(title, subtitle,colorText: Colors.black);
}


logout(){
  auth.signOut().then((value){
    Get.offAllNamed(RoutesName.loginScreen);
  }).catchError((e){
    Get.offAllNamed(RoutesName.loginScreen);
  });
}

customDialog({required VoidCallback onClick,required title,required content
,  textYes = "Yes", textNo = "No"}){
  Get.defaultDialog(
    title: title,
    content: Text(content),
    textCancel: textNo,
    textConfirm: textYes,
    onConfirm: onClick,
  );
}

Future<void> selectDateFun(BuildContext context, DateTime? _selectedDate) async {
  print("RUn");
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != _selectedDate) {
    Provider.of<ValueProvider>(context,listen: false).setSelectedDate(picked);
  }
}

Future<void> selectDateRangeFun(BuildContext context) async {
  final initialDateRange = Provider.of<ValueProvider>(context, listen: false).selectedDateRange ?? DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 7)),
  );

  final DateTimeRange? picked = await showDateRangePicker(
    context: context,
    initialDateRange: initialDateRange,
    firstDate: DateTime(1990),
    lastDate: DateTime(2030),
  );

  if (picked != null && picked != initialDateRange) {
    Provider.of<ValueProvider>(context, listen: false).setSelectedDateRange(picked);
  }
}

// Future<void> selectDateRangeFun(BuildContext context) async {
//   final initialDateRange = Provider.of<ValueProvider>(context, listen: false).selectedDateRange ?? DateTimeRange(
//     start: DateTime.now(),
//     end: DateTime.now().add(Duration(days: 7)),
//   );
//
//   final DateTimeRange? picked = await showDialog<DateTimeRange>(
//     context: context,
//     builder: (context) {
//       DateTimeRange? tempPickedDateRange = initialDateRange;
//
//       return AlertDialog(
//         title: Text('Select Date Range'),
//         content: Container(
//           height: 300,
//           child: Column(
//             children: [
//               DateRangePickerDialog(
//                 initialDateRange: initialDateRange,
//                 firstDate: DateTime(1990),
//                 lastDate: DateTime(2025),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(tempPickedDateRange);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
//
//   if (picked != null && picked != initialDateRange) {
//     Provider.of<ValueProvider>(context, listen: false).setSelectedDateRange(picked);
//   }
// }

String formatDateRange(DateTimeRange? range) {
  if (range == null) return 'No date range selected.';
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  final String start = formatter.format(range.start);
  final String end = formatter.format(range.end);
  return '$start-$end';
}


void showCustomDialog({
  required VoidCallback onDelete,
  required VoidCallback onDetails,
  required VoidCallback onEdit,
  bool isThird = true,
  bool isSecond = true,
  String thirdText = "Open",
  String secondText = "edit",
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: Get.width * 0.82,
        height: Get.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text(
              'Tap any to take Action',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(isThird)
                TextButton(
                  onPressed: onDetails,
                  child: TextWidget(text: thirdText,size: 12.0,color: Colors.white,),
                ),
                if(isSecond)
                TextButton(
                  onPressed: onEdit,
                  child: TextWidget(text: secondText,size: 12.0,color: Colors.white,),
                ),
                TextButton(
                  onPressed: onDelete,
                  child: TextWidget(text: "Delete",size: 12.0,color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<String> pickAndUpdateFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'], // Allow PDF files
  );

  if (result != null && result.files.isNotEmpty) {
    final pickedFile = result.files.single;
    final double fileSizeInMB = pickedFile.size / (1024 * 1024);

    log("Selected file size: ${fileSizeInMB.toStringAsFixed(2)} MB");
    // Check if file size is greater than 25 MB
    if (pickedFile.size > 25 * 1024 * 1024) {
      showSnackBar(title: "File size should not exceed 25 MB",subtitle: "");
      return "";
    }

    log("path is ${pickedFile.path}");
    return pickedFile.path!;
  } else {
    // Show an error message if no file was selected
    showSnackBar(title: "Please pick a file",subtitle: "");
    return "";
  }
}

void showCustomDialogBox({
  required VoidCallback onDelete,
  required VoidCallback onEdit,
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: Get.width * 0.82,
        height: Get.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap any to take Action',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  TextButton(
                    onPressed: onEdit,
                    child: TextWidget(text: "Edit",size: 12.0,color: Colors.white,),
                  ),
                TextButton(
                  onPressed: onDelete,
                  child: TextWidget(text: "Delete",size: 12.0,color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

