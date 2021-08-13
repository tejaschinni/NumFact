import 'package:caloriescounter/caloriescounter/userRegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  bool isWorking = true;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.5;
  double todaycal = 1700, today = 0.0;
  double _bmi = 0, _bmr = 0;

  String bmi = '0';
  double bmr = 0.0;
  String name = '', gender = '';
  Timestamp startTimestamp = Timestamp.now();
  late DateTime dob;
  DateTime startDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final date2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    heightController.text = height.toString();
    // userNameController.text = name;
    weigthController.text = weigth.toString();
    setState(() {});
    _readUserdetails();
    _read();
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
        Get.off(UserRegisterPage(widget.gUser, widget.signOut));
      }
    });
  }

  void calculate() async {
    setState(() {
      bmi = (weigth / height).toString();
      var heigthcm = (height * 30.48);
      print(heigthcm);
      //  print(bmi.toString().substring(0, 5));
      if (bmi.contains('.')) {
        bmi = bmi.toString();
        // bmr = bmr.toString();
      }
      var difference =
          (date2.difference(startDateTime).inDays / 365).floor().toString();

      print(difference);

      if (gender == "Male") {
        bmr = (66.47 +
            (13.75 * weigth) +
            (5.003 * heigthcm) -
            (6.755 * int.parse(difference)));
        //  bmr = _bmr.toString();
        print('________bmr_____MAle___' + bmr.toString());
      } else if (gender == "Female") {
        bmr = (655.1 +
            (9.563 * weigth) +
            (1.85 * heigthcm) -
            (4.676 * int.parse(difference)));
        //  bmr = _bmr.toString();
        print('________bmr_____Female___' + bmr.toString());
      }
      //BMR for Women = 655.1 + (9.563 * weight [kg]) + (1.85 * size [cm]) − (4.676 * age [years])
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
          gender = value["gender"];
          _bmi = double.parse(value["bmi"].toString());
          _bmr = double.parse(value["bmr"].toString());
          startDateTime = value["DOB"];
        });
        // calculate();
      });
    });
  }

  // void _readUsercal() async {
  //   setState(() {
  //     FirebaseFirestore.instance
  //         .collection("caloriecounter")
  //         .doc(widget.gUser.email.toString())
  //         .collection('food')
  //         .doc(widget.selectedDate.toString())
  //         .get()
  //         .then((DocumentSnapshot value) {
  //       setState(() {});
  //       calculate();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Data'),
      //   actions: [
      //     Center(
      //       child: Container(
      //         padding: EdgeInsets.all(5),
      //         child: InkWell(
      //           child: Icon(Icons.person),
      //           onTap: () {
      //             widget.signOut();
      //             Navigator.pushReplacement(context,
      //                 MaterialPageRoute(builder: (contex) => SigInPage()));
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // calculate();
          setState(() {
            print('-------' + name);
            print('weight---------' + weigth.toString());
            print('height---------' + height.toString());
            print('______bmr-' + _bmi.toString());
          });
        },
      ),
      body: SafeArea(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Container(
            child: Column(
              children: [
                ListTile(
                  title: Text('User Name '),
                  trailing: Text(name),
                ),
                ListTile(
                  title: Text('Height '),
                  trailing: Text(height.toString()),
                ),
                ListTile(
                  title: Text('weight '),
                  trailing: Text(weigth.toString()),
                ),
                // ListTile(
                //   title: Text('Weight '),
                //   trailing: Container(
                //     width: 60,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: TextField(
                //             controller: weigthController,
                //             onChanged: (String val) {
                //               setState(() {
                //                 val = weigth.toString();
                //               });
                //             },
                //             keyboardType: TextInputType.number,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                ListTile(
                  title: Text('BMI'),
                  trailing: Text(_bmi.floor().toString()),
                ),
                ListTile(
                  title: Text('BMR'),
                  trailing: Text(_bmr.floor().toString()),
                ),
                ListTile(
                  title: Text('DOB'),
                  trailing: Text(startDateTime.day.toString() +
                      '-' +
                      startDateTime.month.toString() +
                      '-' +
                      startDateTime.year.toString()),
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      // child: LinearProgressIndicator(
                      //   value: getBMRratio(),
                      //   minHeight: 20,
                      //   backgroundColor: Colors.white,
                      //   valueColor: AlwaysStoppedAnimation<Color>(
                      //       getIndigatorColor(todaycal / bmr)),
                      // ),
                    ),
                    Text(todaycal.toString() + ' / ' + bmr.toString())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _read() async {
    //print(' My email  = ' + widget.gUser.email.toString());
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .get();
      setState(() {
        startTimestamp = (documentSnapshot.data() as dynamic)['DOB'];
        startDateTime = DateTime.fromMicrosecondsSinceEpoch(
            startTimestamp.microsecondsSinceEpoch);
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

  double getBMRratio() {
    return todaycal / bmr;
  }
}
