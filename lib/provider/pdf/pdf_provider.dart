import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/foundation.dart';
import 'package:mom_dance/services/pdf/pdf_services.dart';

import '../../constant.dart';

class PdfProvider extends ChangeNotifier {

  String _filePath ="";
  String _downloadUrl ="";
  String _fileSize ="";
  bool _uploading = false;

  String get filePath => _filePath;
  String get downloadUrl => _downloadUrl;
  String get fileSize => _fileSize;
  bool get uploading => _uploading;




 Future<String> pickAndUpdateFile() async {
   final result = await FilePicker.platform.pickFiles(
     type: FileType.custom,
     allowedExtensions: ['pdf'], // Allow PDF files
   );

   if (result != null && result.files.isNotEmpty) {
     final pickedFile = result.files.single;
     final double fileSizeInMB = pickedFile.size / (1024 * 1024);

     log("Selected file size: ${fileSizeInMB.toStringAsFixed(2)} MB");
     _fileSize  = "${fileSizeInMB.toStringAsFixed(2)} MB";
     setPdfFileSize("${fileSizeInMB.toStringAsFixed(2)} MB");
     notifyListeners();
     // Check if file size is greater than 25 MB
     if (pickedFile.size > 25 * 1024 * 1024) {
       showSnackBar(title: "File size should not exceed 25 MB",subtitle: "");
       return "";
     }

     log("path is ${pickedFile.path}");
     _filePath = pickedFile.path!.toString();
     notifyListeners();
     return pickedFile.path!;
   } else {
     // Show an error message if no file was selected
     showSnackBar(title: "Please pick a file",subtitle: "");
     return "";
   }
 }

 void setPdfFile(String filePath){
   _filePath = filePath;
   notifyListeners();
 }
void clearPdfFile(){
   _filePath = "";
   notifyListeners();
}
  void setPdfFileSize(String fileSize){
    _fileSize = fileSize;
    notifyListeners();
  }

   Future<String> uploadToDatabase(String filePath) async {
    try {
      String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
      File pickedImage = File(filePath);

      if (pickedImage.existsSync()) {
        storage.Reference reference = storage.FirebaseStorage.instance
            .ref()
            .child("Profile Image/$uniqueId");

        // Start the upload task
        storage.UploadTask uploadTask = reference.putFile(pickedImage);

        // Await for upload to complete
        await uploadTask.whenComplete(() => null);

        // After upload is complete, retrieve the download URL
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } else {
        throw Exception('File does not exist at the provided path');
      }
    } catch (e) {
      // Handle database errors
     log(e.toString());
      rethrow;
    }
  }

}
