import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NutritionPerDay extends StatefulWidget {
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  NutritionPerDay(this.gUser, this.selectedDate);

  @override
  _NutritionPerDayState createState() => _NutritionPerDayState();
}

class _NutritionPerDayState extends State<NutritionPerDay> {
  bool flag = false;
  int tcab = 0, tcal = 0, tfat = 0, tgram = 0, tprot = 0;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('caloriecounter')
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var food;

          try {
            food = snapshot.data!.data();

            setState(() {
              flag = false;
            });
          } catch (e) {
            print("NO DATA");
          }
          return flag
              ? Container()
              : Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Center(
                    child: food == null
                        ? Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Calories',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Carbs',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Fat',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Protiens',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tcalories'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Calories',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tcrabs'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Carbs',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tfat'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Fat',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: Text(
                                          food['tprotiens'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text('Protiens',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                );
        },
      ),
    ));
  }

  void _read() async {
    try {
      FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('food')
          .doc(widget.selectedDate.toString())
          .collection('meals')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          tcab = 0;
          tcal = 0;
          tfat = 0;
          tgram = 0;
          tprot = 0;
          for (var item in querySnapshot.docs) {
            tcab = tcab + int.parse(item['carbon'].toString());
            tcal = tcal + int.parse(item['calories'].toString());
            tfat = tfat + int.parse(item['fats'].toString());
            tprot = tprot + int.parse(item['protiens'].toString());
            tgram = tgram + int.parse(item['grams'].toString());
            collection
                .doc(widget.gUser.email)
                .collection('food')
                .doc(widget.selectedDate.toString())
                .set({
              'tcalories': tcal,
              'tcrabs': tcab,
              'tfat': tfat,
              'tprotiens': tprot,
              'tgram': tgram
            });
          }
        });
        print('Carbon Total  ' + tcab.toString());
        print('calories Total  ' + tcal.toString());
        print('fats Total  ' + tfat.toString());
        print('protiens Total  ' + tprot.toString());
      });
    } catch (e) {
      print(e);
    }
  }
}
