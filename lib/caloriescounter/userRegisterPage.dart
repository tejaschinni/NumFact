import 'package:caloriescounter/caloriescounter/homePage.dart';
import 'package:caloriescounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRegisterPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  //DateTime selectedDate;

  UserRegisterPage(this.gUser, this.signOut);
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  String name = '', gender = '';
  int weigth = 0, mobile = 0;
  double height = 0.0;

  bool validator = true;
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // userNameController.text = widget.userData.name.toString();
      // weigthController.text = widget.userData.weigth.toString();
      // mobileController.text = widget.userData.mobile.toString();
    });

    print(widget.gUser.email.toString());
  }

  void validate() {
    if (userNameController.text.length > 2) {
      print('----------------true');
    } else {
      print('----------------false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userDetail();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(widget.gUser, widget.signOut)));

          print("------------date " +
              dateTime.toString() +
              '-------------' +
              gender);
        },
      ),
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          Center(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                widget.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => SignInPage()));
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('User Name'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 6, right: 6),
                    child: TextField(
                      controller: userNameController,
                      onChanged: (String val) {
                        setState(() {
                          name = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Gender'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                    child: Container(
                        child: DropdownButton<String>(
                  items: <String>['Male', 'Female'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    gender = value!;
                  },
                )))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('DOB'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date',
                      onChanged: (val) {
                        dateTime = DateTime.parse(val);
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Height'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: TextField(
                      controller: heightController,
                      onChanged: (String val) {
                        setState(() {
                          height = double.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('weight'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: TextField(
                      controller: weigthController,
                      keyboardType: TextInputType.number,
                      onChanged: (String val) {
                        setState(() {
                          weigth = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Height'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Goal'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> userDetail() async {
    collection.doc(widget.gUser.email).set({
      'name': name,
      'height': height,
      'weigth': weigth,
      'joindate': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      'DOB': dateTime,
      'gender': gender
    });
  }
}
