import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Food>> fetchFoods(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/tejaschinni/Demo/master/lib/lib/food.json'));

  // Use the compute function to run parseFoods in a separate isolate.
  return compute(parseFoods, response.body);
}

// A function that converts a response body into a List<Food>.
List<Food> parseFoods(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}

class Food {
  final String gram;
  final String calories;
  final String fats;
  final String carbon;
  final String protein;
  final String name;

  Food({
    required this.gram,
    required this.calories,
    required this.fats,
    required this.carbon,
    required this.protein,
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      gram: json['gram'] as String,
      calories: json['calories'] as String,
      fats: json['fats'] as String,
      protein: json['protein'] as String,
      carbon: json['carbon'] as String,
      name: json['name'] as String,
    );
  }
}

class Parse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Food>>(
        future: fetchFoods(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? FoodList(Foods: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class FoodList extends StatelessWidget {
  final List<Food> Foods;

  FoodList({Key? key, required this.Foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Foods.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          Foods[index].name,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text(
                        Foods[index].gram + 'gram',
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
                        style: TextStyle(color: Colors.blue.shade900),
                      ),
                      Row(
                        children: [
                          Text(
                            'C  :  ' + Foods[index].calories + 'g',
                            style: TextStyle(
                                color: Colors.blue.shade900, fontSize: 10),
                          ),
                          Text(
                            'C  :  ' + Foods[index].carbon + 'g',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          // Text(
                          //   'P  :  ' + Foods[index].carbon + 'g',
                          //   style: TextStyle(
                          //       fontSize: 10, color: Colors.blueAccent),
                          // ),
                          // SizedBox(
                          //   width: 15,
                          // ),
                          // Text(
                          //   'F : ' + Foods[index].fats + 'g',
                          //   style: TextStyle(
                          //       fontSize: 10, color: Colors.orangeAccent),
                          // ),
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
      },
    );
  }
}
