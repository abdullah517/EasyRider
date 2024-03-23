import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Driverregprovider1 extends ChangeNotifier {
  String frontimage = '';
  String backimage = '';
  void updatefrontpath(String path) {
    frontimage = path;
    notifyListeners();
  }

  void updatebackpath(String path) {
    backimage = path;
    notifyListeners();
  }

  bool checkisempty() {
    return frontimage == '' || backimage == '';
  }

  Future<void> saveImages(String userId, String folderName) async {
    try {
      final frontImageFile = File(frontimage);
      final frontImageRef = FirebaseStorage.instance
          .ref('drivers/$userId/$folderName/frontimage.png');
      await frontImageRef.putFile(frontImageFile);

      final backImageFile = File(backimage);
      final backImageRef = FirebaseStorage.instance
          .ref('drivers/$userId/$folderName/backimage.png');
      await backImageRef.putFile(backImageFile);
    } catch (e) {
      //
    }
  }
}

class Cardrivercnic extends Driverregprovider1 {}

class Cardriverlicence extends Driverregprovider1 {}

class Motodrivercnic extends Driverregprovider1 {}

class Motodriverlicence extends Driverregprovider1 {}

class Driverregprovider2 extends ChangeNotifier {
  File? image;
  void updateimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  bool checkisempty() {
    return image == null;
  }

  Future<void> saveImage(String userId, String folderName) async {
    try {
      final imageRef =
          FirebaseStorage.instance.ref('drivers/$userId/$folderName/image.jpg');
      await imageRef.putFile(image!);
    } catch (e) {
      //
    }
  }
}

class Motobasicinfo extends Driverregprovider2 {}

class Carbasicinfo extends Driverregprovider2 {}

class Motoselfieid extends Driverregprovider2 {}

class Carselfieid extends Driverregprovider2 {}

class Motovehiclephoto extends Driverregprovider2 {}

class Carvehiclephoto extends Driverregprovider2 {}

class Driverregprovider3 extends ChangeNotifier {
  File? img1;
  File? img2;
  void updateimg1() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      img1 = File(pickedFile.path);
      notifyListeners();
    }
  }

  void updateimg2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      img2 = File(pickedFile.path);
      notifyListeners();
    }
  }

  bool checkisempty() {
    return img1 == null || img2 == null;
  }

  Future<void> saveImages(String userId, String folderName) async {
    try {
      final imageRef1 =
          FirebaseStorage.instance.ref('drivers/$userId/$folderName/img1.jpg');
      final imageRef2 =
          FirebaseStorage.instance.ref('drivers/$userId/$folderName/img2.jpg');
      await imageRef1.putFile(img1!);
      await imageRef2.putFile(img2!);
    } catch (e) {
      //
    }
  }
}

class Carreg extends Driverregprovider3 {}

class Motoreg extends Driverregprovider3 {}
