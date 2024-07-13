import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PdfServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = _storage.ref().child('uploads/$fileName');
      await reference.putFile(file);
      String downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Error uploading file: $e');
      return null;
    }
  }
}
