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

  double _bmi = 0, _bmr = 0;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.5;
  String name = '', gender = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readUserdetails();
    _read();
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
          gender = value["gender"];
          _bmi = double.parse(value["bmi"].toString());
          _bmr = double.parse(value["bmr"].toString());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
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
                    child: Center(
                        child: food == null
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text('Calories '),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: LinearProgressIndicator(
                                          value: 0.0,
                                          minHeight: 30,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              getIndigatorColor(
                                                  food['tcalories'] / _bmr)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            : Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text('Calories'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: LinearProgressIndicator(
                                          value: food['tcalories'] / _bmr,
                                          minHeight: 30,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              getIndigatorColor(
                                                  food['tcalories'] / _bmr)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(food['tcalories'].toString() +
                                        '/' +
                                        _bmr.floor().toString())
                                  ],
                                ),
                              )),
                  );
          },
        ),
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

  Color getIndigatorColor(double d) {
    if (d > .1 && d < .5) {
      return Colors.red;
    } else if (d > 0.5 && d < 0.7) {
      return Colors.yellow;
    } else if (d > 0.7 && d < 1) {
      return Colors.green;
    }
    return Colors.grey;
  }
}
