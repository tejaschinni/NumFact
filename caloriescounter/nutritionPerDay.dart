import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NutritionPerDay extends StatefulWidget {
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  NutritionPerDay(this.gUser, this.selectedDate);

  @override
  _NutritionPerDayState createState() => _NutritionPerDayState();
}

class _NutritionPerDayState extends State<NutritionPerDay> {
  bool flag = false;
  int tcab = 0, tcal = 0, tfat = 0, tgram = 0, tprot = 0, tcalories = 0;

  double _bmi = 0, _bmr = 0, _setgoal = 0.0;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.0;
  String name = '', gender = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime currentdate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _read();
      totalCalData();
    });

    _readUserdetails();
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
          _setgoal = double.parse(value["setgoal"].toString());
        });
      });
    });
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
          final List<ChartData> chartData = [
            ChartData('Total Calories', food['tcalories']),
            ChartData('BMR', _setgoal),
          ];
          final List<ChartData> chartData1 = [
            ChartData('Total Calories', 0),
            ChartData('BMR', _setgoal),
          ];
          //totalCalData();
          return flag
              ? Container()
              : Container(
                  child: Center(
                      child: food['tcalories'] == 0
                          ? Container(
                              padding: EdgeInsets.all(10),
                              child: SfCircularChart(series: <CircularSeries>[
                                // Render pie chart
                                PieSeries<ChartData, String>(
                                  radius: '100%',
                                  dataSource: chartData1,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                )
                              ]))
                          : Container(
                              padding: EdgeInsets.all(10),
                              child: SfCircularChart(series: <CircularSeries>[
                                // Render pie chart
                                PieSeries<ChartData, String>(
                                  radius: '100%',
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                )
                              ]))),
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
          }
        });
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
        print('Carbon Total  ' + tcab.toString());
        print('calories Total  ' + tcal.toString());
        print('fats Total  ' + tfat.toString());
        print('protiens Total  ' + tprot.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  void totalCalData() {
    if (widget.selectedDate == currentdate) {
      print("Dont do change ");
    } else if (widget.selectedDate != currentdate) {
      print("Change");
      if (tcab != 0) {
        collection
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .set({
          'tcalories': 0,
          'tcrabs': 0,
          'tfat': 0,
          'tprotiens': 0,
          'tgram': 0,
        });
      } else {
        print("dont tc chnage ");
      }
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

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final String x;
  final num y;
}
