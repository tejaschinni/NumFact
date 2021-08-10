import 'dart:convert';

import 'package:caloriescounter/caloriescounter/addFood.dart';
import 'package:caloriescounter/caloriescounter/flutterDateTime.dart';
import 'package:caloriescounter/caloriescounter/nutritionPerDay.dart';
import 'package:caloriescounter/caloriescounter/userRegisterPage.dart';
import 'package:caloriescounter/data/food.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:caloriescounter/demo/selectedOptionTab.dart';
import 'package:caloriescounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class DashBoardPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DashBoardPage(this.gUser, this.signOut);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool isWorking = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Recipies> userRecipieList = [];
  List<Food> foods = [];

  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool flag = false;
  Timestamp startTimestamp = Timestamp.now();
  DateTime startDateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateTime();
    _readUserRecipeList();
    getList(http.Client());
    // _readUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectOptionTab(
                          widget.gUser,
                          _selectedDate,
                          widget.signOut,
                          userRecipieList,
                          foods)));
            });
          },
        ),
        // appBar: AppBar(
        //   title: Text('View Data'),
        //   actions: [
        //     Center(
        //       child: Container(
        //         padding: EdgeInsets.all(5),
        //         child: InkWell(
        //           child: Icon(Icons.person),
        //           onTap: () {
        //             widget.signOut();
        //             Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (contex) => SignInPage()));
        //           },
        //         ),
        //       ),
        //     ),
        //     Center(
        //       child: Container(
        //         padding: EdgeInsets.all(5),
        //         child: InkWell(
        //           child: Icon(Icons.smart_display),
        //           onTap: () {
        //             print(userRecipieList);
        //             // Navigator.pushReplacement(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //         builder: (contex) => ListViewSearchBar(
        //             //             widget.gUser,
        //             //             widget.signOut,
        //             //             userRecipieList,
        //             //             _selectedDate)));
        //           },
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body:
            // isWorking
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            DelayedDisplay(
                delay: Duration(seconds: 1),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('caloriecounter')
                      .doc(widget.gUser.email)
                      .collection('food')
                      .doc(_selectedDate.toString())
                      .collection('meals')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var food;

                    try {
                      food = snapshot.data!.docs;

                      setState(() {
                        flag = false;
                      });
                    } catch (e) {
                      print("NO DATA");
                    }
                    if (flag) {
                      return Container();
                    } else {
                      return Column(
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: NutritionPerDay(widget.gUser, _selectedDate),
                          )),
                          Expanded(
                              child: Container(
                                  child: FlutterDateTimeDemo(
                                      startDateTime, setDateTime))),
                          Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: food.length == 0
                                    ? Container(
                                        child: Center(
                                            child: Text('NO DATA Found')))
                                    : ListView.builder(
                                        itemCount: food.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.2,
                                                    color: Colors.grey)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: food[index]
                                                                    ['name']
                                                                .toString(),
                                                            style: DefaultTextStyle
                                                                    .of(context)
                                                                .style,
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text: '\n ' +
                                                                      food[index]
                                                                              [
                                                                              'grams']
                                                                          .toString() +
                                                                      ' g',
                                                                  style:
                                                                      TextStyle()),
                                                            ],
                                                          ),
                                                        ))),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.all(12),
                                                    child: RichText(
                                                      textAlign:
                                                          TextAlign.right,
                                                      text: TextSpan(
                                                        text: food[index]
                                                                ['calories']
                                                            .toString(),
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: '\nC: ' +
                                                                  food[index][
                                                                          'carbon']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey)),
                                                          TextSpan(
                                                              text: '\t F: ' +
                                                                  food[index][
                                                                          'fats']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .orange)),
                                                          TextSpan(
                                                              text: '\t P: ' +
                                                                  food[index][
                                                                          'protiens']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .red))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                              )),
                        ],
                      );
                    }
                  },
                )));
  }

  void _readUserRecipeList() async {
    firestore
        .collection("caloriecounter")
        .doc(widget.gUser.email)
        .collection('recipes')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          int cal =
              int.parse((result.data() as dynamic)['calories'].toString());
          int carb = int.parse((result.data() as dynamic)['carbon'].toString());
          int fat = int.parse((result.data() as dynamic)['fats'].toString());
          int gram = int.parse((result.data() as dynamic)['grams'].toString());
          int pro =
              int.parse((result.data() as dynamic)['protiens'].toString());
          print(cal);
          Recipies r = Recipies(cal, carb, fat, gram,
              (result.data() as dynamic)['name'], pro, result.reference);
          userRecipieList.add(r);
        });
      });
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) =>
                    UserRegisterPage(widget.gUser, widget.signOut)));
      }
    });
  }

  void _getDateTime() async {
    //print(' My email  = ' + widget.gUser.email.toString());
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .get();
      setState(() {
        startTimestamp = (documentSnapshot.data() as dynamic)['date'];
        startDateTime = DateTime.fromMicrosecondsSinceEpoch(
            startTimestamp.microsecondsSinceEpoch);
      });
    } catch (e) {
      print(e);
    }
  }

  void setDateTime(DateTime _selectedValue) {
    setState(() {
      this._selectedDate = DateTime(
          _selectedValue.year, _selectedValue.month, _selectedValue.day);
    });

    print('--------sss-----------' + _selectedDate.toString());
  }

  Future<void> getList(http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://raw.githubusercontent.com/tejaschinni/caloriecounter/main/food.json'));

    setState(() {
      foods = (json.decode(response.body) as List)
          .map((data) => Food.fromJson(data))
          .toList();
    });
  }
}
