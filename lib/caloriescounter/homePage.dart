import 'package:caloriescounter/caloriescounter/dashBoardPage.dart';
import 'package:caloriescounter/caloriescounter/profilePage.dart';
import 'package:caloriescounter/caloriescounter/userRegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  HomePage(this.gUser, this.signOut);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWorking = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readUser();
  }

  void _readUser() {
    FirebaseFirestore.instance
        .collection("caloriecounter")
        .doc(widget.gUser.email.toString())
        .get()
        .then((value) {
      if (value.data() == null) {
        setState(() {
          isWorking = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (contex) => UserRegisterPage(
                      widget.gUser,
                      widget.signOut,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Caloriecounter'),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.home),
                onTap: () {
                  widget.signOut();
                },
              ),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            DashBoardPage(widget.gUser, widget.signOut),
            ProfilePage(widget.gUser, widget.signOut)
          ]),
        ),
      ),
    );
  }
}
