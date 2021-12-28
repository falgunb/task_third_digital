import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_third_digital/ui/add_student_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final Stream<QuerySnapshot> studentStream = FirebaseFirestore.instance
      .collection("students")
      .doc("1234")
      .collection("studentList")
      .snapshots();

  @override
  void initState() {
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
      body: StreamBuilder(
        stream: studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something got wrong..");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // print("data ${snapshot.data!.docChanges[1].doc['name']}");
          return Container(
            width: double.infinity,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  int total;
                  total = int.parse(snapshot.data!.docs[index]['subA']) +
                      int.parse(snapshot.data!.docs[index]['subB']) + int.parse(snapshot.data!.docs[index]['subC']);
                  var percentage = (total/(300.0))*100;
                  print(percentage.toString());
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStudentScreen(data: snapshot.data!.docs[index],)));
                    },
                    child: Card(
                        color: Colors.cyanAccent[90],
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: const FlutterLogo(
                                  size: 70,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snapshot.data!.docs[index]['name']),
                                    Text(snapshot.data!.docs[index]['subA']),
                                    Text(snapshot.data!.docs[index]['subB']),
                                    Text(snapshot.data!.docs[index]['subC']),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1,child: Text("Out of 300 is ${percentage.toStringAsFixed(2)}"))
                            ],
                          ),
                        )),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddStudentScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
