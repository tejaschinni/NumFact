import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddRecipePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  AddRecipePage(this.gUser, this.selectedDate, this.signOut);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  bool validator = true;

  String name = ' ';
  int grams = 0, carbon = 0, fats = 0, protiens = 0, calories = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void validate() {
    if (nameController.text.length > 2) {
      setState(() {
        validator = true;
      });
    } else {
      setState(() {
        validator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                // Container(
                //   child: Text('Add recipes as Per 100 g'),
                // ),
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
          addFood();
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

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewPage(widget.gUser, widget.signOut)));

          // if (validator) {
          //   print('name is not given ');
          // } else {
          //   print('name is  given ');
          // }
        },
      ),
    );
  }

  Future<void> addFood() async {
    collection.doc(widget.gUser.email).collection('recipes').doc().set({
      'name': name,
      'fats': fats,
      'grams': grams,
      'protiens': protiens,
      'calories': calories,
      'carbon': carbon
    });
  }
}
