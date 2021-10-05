import 'package:caloriecounter/caloriecounter/addFood.dart';
import 'package:caloriecounter/caloriecounter/createMealPage.dart';
import 'package:caloriecounter/data/food.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:caloriecounter/jsonParsing/libraryFood.dart';
import 'package:caloriecounter/jsonParsing/parse.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddFoodFromRecipie extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Recipies> userRecipeList;
  List<Food> food;
  Function _readUserRecipeList;
  AddFoodFromRecipie(this.gUser, this.selectedDate, this.signOut,
      this.userRecipeList, this.food, this._readUserRecipeList);

  @override
  _AddFoodFromRecipieState createState() => _AddFoodFromRecipieState();
}

class _AddFoodFromRecipieState extends State<AddFoodFromRecipie> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ADD YOUR FOOD'),
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
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'My Recipe',
                ),
                Tab(
                  text: 'librarie',
                ),
                Tab(
                  text: 'Create Meal',
                )
              ],
            ),
          ),
          body: Container(
            child: TabBarView(children: [
              AddFood(widget.gUser, widget.selectedDate, widget.signOut,
                  widget.userRecipeList),
              LibraryFodd(widget.gUser, widget.selectedDate, widget.signOut,
                  widget.food),
              CreateMealPage(
                  widget.food,
                  widget.gUser,
                  widget.selectedDate,
                  widget.signOut,
                  widget.userRecipeList,
                  widget._readUserRecipeList),
            ]),
          ),
        ));
  }
}
