import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class IconUploadService {
  
  FirebaseStorage firebaseStorage = new FirebaseStorage();
  StorageReference storageReference;
  StorageUploadTask storageUploadTask;
  List<String> iconUploadInfo;

  Future<List<String>> uploadIcon(String name, String extension, File file) async {
    
    iconUploadInfo = [];
    storageReference =
        firebaseStorage.ref().child('app_icons').child('$name.$extension');
    storageUploadTask = storageReference.putFile(file);

    iconUploadInfo[0] = await (await storageUploadTask.onComplete).ref.getDownloadURL();;
    iconUploadInfo[1] = storageReference.path.toString();

    return iconUploadInfo;
  }

  Future<void> deleteIcon(String iconPath) async {
    storageReference =firebaseStorage.ref().child(iconPath);
    await storageReference.delete();
  }

}