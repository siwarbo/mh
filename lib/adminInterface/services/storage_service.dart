import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage;
  //=firebase_storage.FirebaseStorage.instance;
  // Constructor with optional storageBucket parameter
  StorageService({String? storageBucket})
      : storage =
            firebase_storage.FirebaseStorage.instanceFor(bucket: storageBucket);

  Future<void> uploadImage(XFile image) async {
    String fileName =
        image.path.split('/').last; // Extracting filename from path
    await storage.ref('product_images/$fileName').putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('product_images/$imageName').getDownloadURL();

    return downloadURL;
  }
}
