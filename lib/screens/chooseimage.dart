// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_class/models/user_model.dart';
import 'package:next_class/screens/profile.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({Key? key}) : super(key: key);

  @override
  _ChooseImageState createState() => _ChooseImageState();
}

final Storage storage = Storage();

class _ChooseImageState extends State<ChooseImage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel logedInUser = UserModel();
  var path;
  var fileName;
  @override
  Widget build(BuildContext context) {
    var a = 0;
    return ListView(
      shrinkWrap: true,
      children: [
        path != null
            ? Image.file(
                File(path),
                fit: BoxFit.cover,
              )
            : Container(),
        OutlinedButton(
          onPressed: () async {
            final resutls = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.image,
              allowCompression: true,
            );
            if (resutls != null) {
              setState(
                () {
                  path = resutls.files.single.path;
                  fileName = resutls.files.single.name;
                },
              );
            }

            if (resutls == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('No File Picked'),
                ),
              );
            }
          },
          child: Text('Choose'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (path != null) {
              setState(
                () {
                  a = 1;
                  storage.uploadFile(path!, fileName).then(
                        (value) => FirebaseFirestore.instance
                            .collection("users")
                            .doc(user!.uid)
                            .update({'imageurl': imgurl})
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Successfully Uploaded',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                            .then(
                              (value) => Navigator.pop(context),
                            ),
                      );
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('No File to Upload'),
                ),
              );
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            }
          },
          child: Text('Upload'),
        ),
      ],
    );
  }
}
