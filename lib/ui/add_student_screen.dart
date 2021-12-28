import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final subACtrl = TextEditingController();
  final subBCtrl = TextEditingController();
  final subCCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: ()=> getImage(ImageSource.gallery),
                        child: const Text('Select From Gallary'),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.all(8),
                        textColor: Colors.white,
                        color: Colors.orange[100],
                        onPressed: ()=> getImage(ImageSource.gallery),
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: TextFormField(
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
                onPressed: (){

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
