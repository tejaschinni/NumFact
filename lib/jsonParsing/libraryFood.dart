import 'dart:convert';

import 'package:caloriescounter/data/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LibraryFodd extends StatefulWidget {
  const LibraryFodd({Key? key}) : super(key: key);

  @override
  _LibraryFoddState createState() => _LibraryFoddState();
}

class _LibraryFoddState extends State<LibraryFodd> {
  List<Food> food = [];
  List<Food> foundfood = [];

  String name = ' ';
  String grams = ' ',
      carbon = ' ',
      fats = ' ',
      protiens = ' ',
      calories = ' ',
      tcab = ' ',
      tcal = ' ',
      tfat = ' ',
      tgram = ' ',
      tprot = ' ';

  Future<void> getList(http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://raw.githubusercontent.com/tejaschinni/caloriecounter/main/food.json'));

    setState(() {
      food = (json.decode(response.body) as List)
          .map((data) => Food.fromJson(data))
          .toList();
      for (int i = 0; i < food.length; i++) {
        Food f = Food(
            gram: food[i].gram,
            calories: food[i].calories,
            fats: food[i].fats,
            protein: food[i].protein,
            carbon: food[i].carbon,
            name: food[i].name);
        foundfood.add(f);
      }
    });
  }

  getfoood() {
    for (int i = 0; i < food.length; i++) {
      setState(() {
        Food f = Food(
            gram: food[i].gram,
            calories: food[i].calories,
            fats: food[i].fats,
            protein: food[i].protein,
            carbon: food[i].carbon,
            name: food[i].name);
        foundfood.add(f);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList(http.Client());

    foundfood = food;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: foundfood.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Text(
                            foundfood[index].name.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    foundfood[index].gram.toString() + 'gram',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ' ',
                                    style:
                                        TextStyle(color: Colors.blue.shade900),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'C  :  ' +
                                            foundfood[index]
                                                .calories
                                                .toString() +
                                            'g',
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        'C  :  ' +
                                            foundfood[index].carbon.toString() +
                                            'g',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'P  :  ' +
                                            foundfood[index].carbon.toString() +
                                            'g',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blueAccent),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'F : ' +
                                            foundfood[index].fats.toString() +
                                            'g',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.orangeAccent),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }

  void _runFilter(String enteredKeyword) {
    List<Food> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = food;
    } else {
      results = food
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundfood = results;
    });
  }
}
