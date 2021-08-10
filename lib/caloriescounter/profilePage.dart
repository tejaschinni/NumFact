import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ProfilePage(this.gUser, this.signOut);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  int weigth = 0;
  double height = 0.0, bmi = 0.0;
  String name = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // heightController.text = height.toString();
    // userNameController.text = name;
    // weigthController.text = weigth.toString();
    _readUserdetails();
    calculate();
  }

  void calculate() {
    setState(() {
      bmi = weigth / height;
      print(bmi.toString());
    });
  }

  void _readUserdetails() async {
    setState(() {
      FirebaseFirestore.instance
          .collection("caloriecounter")
          .doc(widget.gUser.email.toString())
          .get()
          .then((DocumentSnapshot value) {
        setState(() {
          name = value["name"].toString();
          weigth = value["weigth"];
          height = value["height"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          calculate();
        },
      ),
      body: Container(
        child: Column(
          children: [
            Text('User Name = ' + name),
            Text('weight = ' + weigth.toString()),
            Text('Height = ' + height.toString()),
            Text('BMI = ' + bmi.toString()),
          ],
        ),
      ),
    );
  }
}
