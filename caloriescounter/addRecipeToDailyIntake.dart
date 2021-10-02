import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddRecipeToDailyIntake extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  var document;
  Recipies recipes;
  DateTime selectedDate;
  AddRecipeToDailyIntake(
      this.gUser, this.signOut, this.selectedDate, this.document, this.recipes);

  @override
  _AddRecipeToDailyIntakeState createState() => _AddRecipeToDailyIntakeState();
}

class _AddRecipeToDailyIntakeState extends State<AddRecipeToDailyIntake> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  String name = ' ';
  int grams = 0,
      carbon = 0,
      fats = 0,
      protiens = 0,
      calories = 0,
      tcab = 0,
      tcal = 0,
      tfat = 0,
      tgram = 0,
      tprot = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.recipes.name;
    fatsController.text = widget.recipes.fats.toString();
    caloriesController.text = widget.recipes.calories.toString();
    gramsController.text = widget.recipes.grams.toString();
    carbonController.text = widget.recipes.carbon.toString();
    protiensController.text = widget.recipes.protines.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add daily intake '),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Recipe Name'),
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
                          controller: nameController,
                          onChanged: (String val) {
                            setState(() {
                              name = val;
                            });
                            // validate();
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
                        child: Text('Grams'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: gramsController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              grams = int.parse(val);
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
                        child: Text('Protiens'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: protiensController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              protiens = int.parse(val);
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
                        child: Text('Calories'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: caloriesController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              calories = int.parse(val);
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
                        child: Text('Carbs'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: carbonController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              carbon = int.parse(val);
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
                        child: Text('Fat'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: fatsController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              fats = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(" ----------- Document Refernce " +
              widget.recipes.name.toString());
          setState(() {
            addRecipesToDaily();
            calculate();

            nameController.text = "";
            protiensController.text = "";
            caloriesController.text = "";
            gramsController.text = "";
            fatsController.text = "";
            carbonController.text = "";
            name = "";
            fats = 0;
            grams = 0;
            protiens = 0;
            calories = 0;
            carbon = 0;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ViewPage(widget.gUser, widget.signOut)));
          });
        },
      ),
    );
  }

  Future<void> addRecipesToDaily() async {
    firestore
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .doc()
        .set({
      'name': nameController.text,
      'fats': fatsController.text,
      'grams': gramsController.text,
      'protiens': protiensController.text,
      'calories': caloriesController.text,
      'carbon': carbonController.text
    });
  }

  void calculate() async {
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
        print('Carbon Total  ' + tcab.toString());
        print('calories Total  ' + tcal.toString());
        print('fats Total  ' + tfat.toString());
        print('protiens Total  ' + tprot.toString());
        firestore
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
      });
    } catch (e) {
      print(e);
    }
  }
}
