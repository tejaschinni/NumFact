import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:caloriecounter/caloriecounter/addRecipeToDailyIntake.dart';
import 'package:caloriecounter/caloriecounter/editRecipePage.dart';
import 'package:caloriecounter/logouPage.dart';
import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewRecipePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  ViewRecipePage(this.gUser, this.signOut, this.selectedDate);

  @override
  _ViewRecipePageState createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');
  bool flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('recipes')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data!.docs.map((document) {
            return InkWell(
              child: Container(
                padding: EdgeInsets.all(2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
                    title: Text(document['name'].toString()),
                    subtitle: Text(document['grams'].toString()),
                  ),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Edit Recipe',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => EditRecipePage(
                                    widget.gUser,
                                    widget.signOut,
                                    document,
                                    document.reference.id,
                                    widget.selectedDate)));
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete Recipe',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        deleteRecpe(document.reference.id);
                      },
                    ),
                  ],
                ),
              ),
              onTap: () {
                print(document.reference.id);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (contex) => AddRecipeToDailyIntake(
                //             document.reference.id,
                //             widget.gUser,
                //             document,
                //             widget.signOut,
                //             widget.selectedDate)));
              },
            );
          }).toList(),
        );
      },
    ));
  }

  Future<void> deleteRecpe(var document) async {
    firestore
        .doc(widget.gUser.email)
        .collection('recipes')
        .doc(document)
        .delete();
  }
}
