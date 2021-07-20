import 'package:caloriescounter/caloriescounter/AddDailyIntake.dart';
import 'package:caloriescounter/caloriescounter/addFood.dart';
import 'package:caloriescounter/caloriescounter/editRecipiePage.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RecipiesListSearchPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  List<Recipies> userRecipeList;
  DateTime selectedDate;
  //Function setRecipeValue;
  RecipiesListSearchPage(
      this.gUser, this.selectedDate, this.signOut, this.userRecipeList);

  @override
  _RecipiesListSearchPageState createState() => _RecipiesListSearchPageState();
}

class _RecipiesListSearchPageState extends State<RecipiesListSearchPage> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  List<Recipies> _foundRecipe = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foundRecipe = widget.userRecipeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (contex) => AddFood(
                      widget.gUser,
                      widget.selectedDate,
                      widget.signOut,
                      widget.userRecipeList)));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: _foundRecipe.length > 0
                  ? ListView.builder(
                      itemCount: _foundRecipe.length,
                      itemBuilder: (context, index) => InkWell(
                        child: InkWell(
                          child: Slidable(
                            actionPane: SlidableBehindActionPane(),
                            actionExtentRatio: 0.25,
                            child: ListTile(
                              title: Text(
                                _foundRecipe[index].name.toString(),
                              ),
                              subtitle:
                                  Text(_foundRecipe[index].grams.toString()),
                            ),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Edit Recipe',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) => EditRecipiePage(
                                              widget.gUser,
                                              _foundRecipe[index],
                                              _foundRecipe[index].reference.id,
                                              widget.selectedDate,
                                              widget.signOut)));
                                },
                              ),
                              IconSlideAction(
                                caption: 'Delete Recipe',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  deleteRecpe(_foundRecipe[index].reference.id);
                                },
                              ),
                            ],
                          ),
                        ),
                        onLongPress: () {},
                        onTap: () {
                          // widget.setRecipeValue(
                          //     _foundRecipe[index].name,
                          //     _foundRecipe[index].calories,
                          //     _foundRecipe[index].grams,
                          //     _foundRecipe[index].carbon,
                          //     _foundRecipe[index].protines,
                          //     _foundRecipe[index].fats);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => AddDailyInTake(
                                      _foundRecipe[index].reference.id,
                                      widget.gUser,
                                      _foundRecipe[index],
                                      widget.selectedDate,
                                      widget.signOut)));
                          print("On clicked on a particular recipe");
                          print('--------------------' +
                              _foundRecipe[index].name.toString());
                        },
                      ),
                    )
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Recipies> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.userRecipeList;
    } else {
      results = widget.userRecipeList
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundRecipe = results;
    });
  }

  Future<void> deleteRecpe(var document) async {
    firestore
        .doc(widget.gUser.email)
        .collection('recipes')
        .doc(document)
        .delete();

    setState(() {});
  }
}
