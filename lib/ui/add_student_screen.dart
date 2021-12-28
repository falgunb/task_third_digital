import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_third_digital/data/firebase.dart';
import 'package:task_third_digital/ui/second_screen.dart';

class AddStudentScreen extends StatefulWidget {
  final QueryDocumentSnapshot? data;

  AddStudentScreen({Key? key, this.data}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  var dlink;

  final nameCtrl = TextEditingController();
  final subACtrl = TextEditingController();
  final subBCtrl = TextEditingController();
  final subCCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Storage storage = Storage();

  CollectionReference ref = FirebaseFirestore.instance
      .collection("students")
      .doc("1234")
      .collection("studentList");

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print("No image selected");
      }
    });
  }

  @override
  void initState() {
    if (widget.data != null) {
      print("kaik mailu ${widget.data!['name']}");
      nameCtrl.text = widget.data!['name'];

      subACtrl.text = widget.data!['subA'];
      subBCtrl.text = widget.data!['subB'];
      subCCtrl.text = widget.data!['subC'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: const Text("Edit Student"),
              centerTitle: true,
              actions: [IconButton(icon: Icon(Icons.delete), onPressed: () {
                widget.data!.reference.delete().whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen())));
              })],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image == null
                            ? const FlutterLogo(
                                size: 160,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(File(_image!.path)),
                                radius: 80.0,
                              ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              padding: const EdgeInsets.all(8),
                              textColor: Colors.white,
                              color: Colors.orange[100],
                              onPressed: () => getImage(ImageSource.gallery),
                              child: const Text('Select From Gallary'),
                            ),
                            RaisedButton(
                              padding: const EdgeInsets.all(8),
                              textColor: Colors.white,
                              color: Colors.orange[100],
                              onPressed: () => getImage(ImageSource.gallery),
                              child: const Text('Select From Camera'),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    controller: nameCtrl,
                                    // initialValue: widget.data!['name'],
                                    expands: false,
                                    validator: (value) {
                                      if (value!.length < 9 || value.isEmpty) {
                                        return 'Please Full Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Full Name',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: subACtrl,
                                    // initialValue: widget.data!['subA'],
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject A';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject A',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: subBCtrl,
                                    // initialValue: widget.data!['subB'],
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject B';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject B',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                    controller: subCCtrl,
                                    // initialValue: widget.data!['subC'],
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject C';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject C',
                                    ))))),
                    SizedBox(
                      height: 60,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.all(8),
                      textColor: Colors.white,
                      color: Colors.orange[100],
                      onPressed: () {
                        setState(() {});
                        widget.data!.reference.update({
                          'name': nameCtrl.text.toString().trim(),
                          'subA': subACtrl.text.toString().trim(),
                          'subB': subBCtrl.text.toString().trim(),
                          'subC': subCCtrl.text.toString().trim(),
                        }).whenComplete(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SecondScreen())));
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: const Text("Add Student"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image == null
                            ? const FlutterLogo(
                                size: 160,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(File(_image!.path)),
                                radius: 80.0,
                              ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              padding: const EdgeInsets.all(8),
                              textColor: Colors.white,
                              color: Colors.orange[100],
                              onPressed: () => getImage(ImageSource.gallery)
                                  .whenComplete(() {
                                storage
                                    .uploadFile(_image!.path, _image!.name)
                                    .then((value) {
                                  //image uploads but couldn't get download link from the future value
                                });
                              }),
                              child: const Text('Select From Gallary'),
                            ),
                            RaisedButton(
                              padding: const EdgeInsets.all(8),
                              textColor: Colors.white,
                              color: Colors.orange[100],
                              onPressed: () => getImage(ImageSource.gallery),
                              child: const Text('Select From Camera'),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    controller: nameCtrl,
                                    expands: false,
                                    validator: (value) {
                                      if (value!.length < 9 || value.isEmpty) {
                                        return 'Please Full Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Full Name',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: subACtrl,
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject A';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject A',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: subBCtrl,
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject B';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject B',
                                    ))))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: subCCtrl,
                                    expands: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Subject C';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Subject C',
                                    ))))),
                    SizedBox(
                      height: 60,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.all(8),
                      textColor: Colors.white,
                      color: Colors.orange[100],
                      onPressed: () {
                        ref.add({
                          'name': nameCtrl.text.toString().trim(),
                          'subA': subACtrl.text.toString().trim(),
                          'subB': subBCtrl.text.toString().trim(),
                          'subC': subCCtrl.text.toString().trim(),
                        }).whenComplete(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SecondScreen())));
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
