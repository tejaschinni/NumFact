import 'package:caloriescounter/caloriescounter/dashBoardPage.dart';
import 'package:caloriescounter/caloriescounter/recipiesListSearchPage.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddFood extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Recipies> userRecipeList;

  AddFood(this.gUser, this.selectedDate, this.signOut, this.userRecipeList);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  bool validator = true;

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
  }

  void validate() {
    if (nameController.text.length > 2 &&
        gramsController.text.length > 0 &&
        protiensController.text.length > 0 &&
        carbonController.text.length > 0 &&
        caloriesController.text.length > 0 &&
        fatsController.text.length > 0) {
      setState(() {
        validator = true;
        print(' ---------------------------- Validation True ');
      });
    } else {
      setState(() {
        validator = false;
        print(' ---------------------------- Validation false ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Intake' + widget.selectedDate.toString()),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.home),
                onTap: () {
                  widget.signOut();
                },
              ),
            )
          ],
        ),
        body: Container(
          child: Container(
            child: Column(
              children: [
                // Expanded(
                //     flex: 1,
                //     child: Container(
                //         // child:
                //         // RecipiesListSearchPage(
                //         //     widget.gUser,
                //         //     widget.selectedDate,
                //         //     setRecipeValue,
                //         //     widget.signOut,
                //         //     widget.userRecipeList)
                //         )),
                // SizedBox(
                //   height: 10,
                // ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Text('Add your Food'),
                            ),
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
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                                    padding: EdgeInsets.only(
                                        left: 50, top: 8, right: 10),
                                    child: TextField(
                                      controller: gramsController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          grams = int.parse(val);
                                        });
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                                    child: Text('Carbon'),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 50, top: 8, right: 10),
                                    child: TextField(
                                      controller: carbonController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          carbon = int.parse(val);
                                        });
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                                    padding: EdgeInsets.only(
                                        left: 50, top: 8, right: 10),
                                    child: TextField(
                                      controller: protiensController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          protiens = int.parse(val);
                                        });
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                                    padding: EdgeInsets.only(
                                        left: 50, top: 8, right: 10),
                                    child: TextField(
                                      controller: caloriesController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          calories = int.parse(val);
                                        });
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
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
                                    padding: EdgeInsets.only(
                                        left: 50, top: 8, right: 10),
                                    child: TextField(
                                      controller: fatsController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          fats = int.parse(val);
                                        });
                                        validate();
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              validate();
              addFood();
              _read();

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
                          DashBoardPage(widget.gUser, widget.signOut)));
            });
          },
        ));
  }

  Future<void> addFood() async {
    firestore
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .doc()
        .set({
      'name': name,
      'fats': fats,
      'grams': grams,
      'protiens': protiens,
      'calories': calories,
      'carbon': carbon
    });
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

  void setRecipeValue(
      String name, int cal, int grm, int carb, int prot, int fat) {
    setState(() {
      this.grams = grm;
      this.calories = cal;
      this.carbon = carb;
      this.protiens = prot;
      this.fats = fat;
      this.name = name;
      nameController.text = name;
      gramsController.text = grm.toString();
      caloriesController.text = cal.toString();
      carbonController.text = carb.toString();
      fatsController.text = fat.toString();
      protiensController.text = prot.toString();
    });
  }

  void onGramchange(int gram) {
    int __gram = 0, __cal = 0, __carb = 0, __fat = 0, __prot = 0;
    setState(() {
      __gram = int.parse(gramsController.text);
      __cal = int.parse(caloriesController.text);
      __fat = int.parse(fatsController.text);
      __carb = int.parse(carbonController.text) + 2;
      __prot = int.parse(protiensController.text);
    });
  }
}
