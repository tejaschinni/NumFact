import 'package:caloriecounter/caloriecounter/viewRecipePage.dart';
import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EditRecipePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  var refrenceID;
  var recipes;
  DateTime selectedDate;

  EditRecipePage(this.gUser, this.signOut, this.recipes, this.refrenceID,
      this.selectedDate);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  String name = ' ';
  int grams = 0, carbon = 0, fats = 0, protiens = 0, calories = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Recipe id -------------' + widget.refrenceID.toString());
    nameController.text = widget.recipes['name'];
    fatsController.text = widget.recipes['fats'].toString();
    caloriesController.text = widget.recipes['calories'].toString();
    gramsController.text = widget.recipes['grams'].toString();
    carbonController.text = widget.recipes['carbon'].toString();
    protiensController.text = widget.recipes['protiens'].toString();

    recipe();
  }

  void recipe() {
    // print('Recpess page ----------------' + widget.recipes.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Recipe Page'),
        actions: [
          Center(
            child: Container(
              child: InkWell(
                child: Icon(Icons.person),
                onTap: () {
                  widget.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (contex) => SigInPage()));
                },
              ),
            ),
          )
        ],
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
          updatRecipes();
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
                  builder: (context) => ViewRecipePage(
                      widget.gUser, widget.signOut, widget.selectedDate)));

          // if (validator) {
          //   print('name is not given ');
          // } else {
          //   print('name is  given ');
          // }
        },
      ),
    );
  }

  Future<void> updatRecipes() async {
    firestore
        .doc(widget.gUser.email)
        .collection('recipes')
        .doc(widget.refrenceID)
        .update({
          'name': nameController.text,
          'fats': fatsController.text,
          'grams': gramsController.text,
          'protiens': protiensController.text,
          'calories': caloriesController.text,
          'carbon': carbonController.text
        })
        .then((value) => print('Recipes Updated'))
        .catchError((onError) => print('Failed to Update Recipe'));
  }
}
