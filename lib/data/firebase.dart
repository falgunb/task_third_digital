import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_core/firebase_core.dart' as core;
import 'package:image_picker/image_picker.dart';

class Storage {
  final storage.FirebaseStorage _storage = storage.FirebaseStorage.instance;
  String? mainUrl;

  Future<String?> uploadFile(
    String filePath,
    String fileName,
  ) async {
    XFile file = XFile(filePath);
    try{
      var link = await _storage.ref('stu/$fileName').putFile(File(file.path));
      if(link.state == storage.TaskState.success){
        storage.FirebaseStorage.instance.ref('stu/$fileName').getDownloadURL().then((url){
          print("Here is the URL of Image $url");
          mainUrl = url;
        });
      }
    } on core.FirebaseException catch (e){
      print(e.stackTrace);
    }
    return mainUrl;
  }
}
