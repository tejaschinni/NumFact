import 'package:caloriescounter/caloriescounter/addFood.dart';
import 'package:caloriescounter/caloriescounter/recipiesListSearchPage.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:caloriescounter/jsonParsing/parse.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SelectOptionTab extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Recipies> userRecipeList;
  SelectOptionTab(
      this.gUser, this.selectedDate, this.signOut, this.userRecipeList);

  @override
  _SelectOptionTabState createState() => _SelectOptionTabState();
}

class _SelectOptionTabState extends State<SelectOptionTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            AddFood(widget.gUser, widget.selectedDate, widget.signOut,
                widget.userRecipeList),
            Parse(),
          ]),
        ),
      ),
    );
  }
}
