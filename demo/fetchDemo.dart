import 'package:caloriecounter/data/recipies.dart';
import 'package:caloriecounter/data/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FetchDemo extends StatefulWidget {
  @override
  _FetchDemoState createState() => _FetchDemoState();
}

class _FetchDemoState extends State<FetchDemo> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Student> stud = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readUserRecipeList();
  }

  void _readUserRecipeList() async {
    firestore.collection("student").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          int roll = (result.data() as dynamic)['roll'];
          String name = (result.data() as dynamic)['name'];
          String stream = '';
          try {
            stream = (result.data() as dynamic)['stream'];
          } catch (e) {
            stream = '--';
          }

          Student s = Student(roll, name, stream, result.reference);
          stud.add(s);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data '),
        ),
        // body: StreamBuilder(
        //   stream: firestore.collection("student").snapshots(),
        //   builder: (BuildContext context,
        //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     return ListTile();
        //   },
        // ),
        body: Container(
            child: ListView.builder(
                itemCount: stud.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Text(stud[index].roll.toString()),
                      title: Text(stud[index].name),
                      trailing: Text(stud[index].stream + '\t '),
                    ),
                  );
                })),
      ),
    );
  }
}
