import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_third_digital/model/user_model.dart';
import 'package:task_third_digital/ui/add_student_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List? _list;

  final _fireStore = FirebaseFirestore.instance;

  Future<void> getData() async {
    var myData = _fireStore
        .collection('students')
        .doc('1234')
        .collection('studentList')
        .get()
        .then((value){
          setState(() {
            _list!.add(value);
          });

    });

    print("all Data ${myData}");
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Students List"),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _list!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: Colors.cyanAccent[90],
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlutterLogo(
                        size: 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_list![index]['name'] ?? ""),
                          Text(_list![index]['subA'] ?? ""),
                          Text(_list![index]['subB'] ?? ""),
                          Text(_list![index]['subC'] ?? ""),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddStudentScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
