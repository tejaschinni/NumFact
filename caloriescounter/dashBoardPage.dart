import 'package:caloriecounter/caloriecounter/profilePage.dart';
import 'package:caloriecounter/caloriecounter/userRegisterPage.dart';
import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashBoardPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DashBoardPage(this.gUser, this.signOut);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool isWorking = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _readUser();
    });
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
        Get.to(UserRegisterPage(widget.gUser, widget.signOut));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(seconds: 3),
      child: DefaultTabController(
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
              ViewPage(widget.gUser, widget.signOut),
              ProfilePage(widget.gUser, widget.signOut)
            ]),
          ),
        ),
      ),
    );
  }
}
