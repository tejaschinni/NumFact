import 'package:caloriecounter/caloriecounter/addFood.dart';
import 'package:caloriecounter/caloriecounter/createMealPage.dart';
import 'package:caloriecounter/data/food.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:caloriecounter/jsonParsing/libraryFood.dart';
import 'package:caloriecounter/jsonParsing/parse.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddFromRecipie extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Recipies> userRecipeList;
  List<Food> food;
  Function _readUserRecipeList;
  AddFromRecipie(this.gUser, this.selectedDate, this.signOut,
      this.userRecipeList, this.food, this._readUserRecipeList);

  @override
  _AddFromRecipieState createState() => _AddFromRecipieState();
}

class _AddFromRecipieState extends State<AddFromRecipie>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Add Food'),
    Tab(text: 'Libary'),
    Tab(text: 'Create Meal'),
  ];
  late TabController _tabController;
  static final _myTabbedPageKey = new GlobalKey<_AddFromRecipieState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: _myTabbedPageKey,
  //     // floatingActionButton: new FloatingActionButton(
  //     //   onPressed: () =>
  //     //       _tabController.animateTo((_tabController.index - 2)), // Switch tabs
  //     //   child: new Icon(Icons.swap_horiz),
  //     // ),
  //     appBar: AppBar(
  //       bottom: TabBar(
  //         controller: _tabController,
  //         tabs: myTabs,
  //       ),
  //     ),
  //     body: TabBarView(
  //       controller: _tabController,
  //       children: myTabs.map((Tab tab) {
  //         final String label = tab.text!;
  //         return getPageView(label);
  //       }).toList(),
  //     ),
  //   );
  // }

  // Widget getPageView(String label) {
  //   print(label);
  //   if (label == 'Add Food') {
  //     return AddFood(widget.gUser, widget.selectedDate, widget.signOut,
  //         widget.userRecipeList);
  //   } else if (label == 'Libary') {
  //     return LibraryFodd(
  //         widget.gUser, widget.selectedDate, widget.signOut, widget.food);
  //   } else if (label == 'Create Meal') {
  //     return CreateMealPage(widget.food, widget.gUser, widget.selectedDate,
  //         widget.signOut, widget.userRecipeList, widget._readUserRecipeList);
  //   } else {
  //     return Container(
  //       child: Text('plz select a tab'),
  //     );
  //   }
  // }
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
