import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

String imgurl = "";


class UserModel {
  String? uid;
  String? email;
  String? name;
  String? dob;
  String? batch;
  String? imageurl;

  UserModel(
      {this.uid, this.email, this.name, this.dob, this.batch, this.imageurl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      dob: map['dob'],
      batch: map['batch'],
      imageurl: map['imageurl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageurl': "imageurl",
    };
  }
}

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('profilepics/$fileName').putFile(file);
      imgurl = await storage.ref('profilepics/$fileName').getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
