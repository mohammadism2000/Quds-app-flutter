import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddnewPost extends StatefulWidget {
  const AddnewPost();
  @override
  _AddnewPostState createState() => _AddnewPostState();
}

class _AddnewPostState extends State<AddnewPost> {
  late FirebaseFirestore fri;
  FirebaseStorage? firebaseStorage;
  File? _image;
  String dicreptioon = 'initdata';
  final picker = ImagePicker();

  @override
  void initState() {
    fri = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    super.initState();
  }

  bool visible = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightImage = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                      height: heightImage * 0.4,
                      child: _image == null
                          ? GestureDetector(
                              onTap: () async {
                                getImage();
                                print('image click');
                              },
                              child: Image.asset(
                                'images/qudsicon.png',
                                fit: BoxFit.cover,
                              ))
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    color: Colors.greenAccent,
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 5,
                        decoration:
                            InputDecoration(hintText: 'Enter a Dicreption'),
                        onChanged: (data) {
                          dicreptioon = data;
                        },
                      ),
                    ),
                  ),
                  //add new post and upload image
                  RaisedButton(
                    onPressed: () async {
                      loadProgress();
                      if (_image != null) {
                        var snapShote = await firebaseStorage!
                            .ref()
                            .child('folderName/imageName${DateTime.now()}')
                            .putFile(_image!)
                            .whenComplete(() => () {
                                  print('UplodeFinash');
                                });
                        String x = await snapShote.ref.getDownloadURL();

                        print('aaaaaaaaaaaaaaaaaaaa');
                        fri.collection('Posteitem').add({
                          'image': x,
                          'like': 0,
                          'detaalse': dicreptioon
                        }).whenComplete(() {
                          loadProgress();

                          final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Yay! A SnackBar!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // ignore: argument_type_not_assignable_to_error_handler
                        }).catchError(() => loadProgress());
                      }
                    },
                    child: Text("add"),
                  )
                ],
              ),
              Visibility(
                visible: visible,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
        dicreptioon = '';
        _image = null;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
