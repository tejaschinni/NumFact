import 'package:caloriescounter/data/user.dart';
import 'package:flutter/material.dart';

class RadioWidgetDemo extends StatefulWidget {
  @override
  RadioWidgetDemoState createState() => RadioWidgetDemoState();
}

class RadioWidgetDemoState extends State<RadioWidgetDemo> {
  late List<User> users;
  List<User> selectedUser = [];
  int selectedRadio = 0;
  int selectedRadioTile = 0;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getUsers();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      if (val == 1) {
        print('option 1');
      } else if (val == 2) {
        print('options 2');
      } else {
        print('----------------');
      }
    });
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user as List<User>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RadioListTile(
            value: 1,
            groupValue: selectedRadioTile,
            title: Text("Radio 1"),
            subtitle: Text("Radio 1 Subtitle"),
            onChanged: (val) {
              setSelectedRadioTile(val as int);
            },
            activeColor: Colors.red,
            secondary: OutlineButton(
              child: Text("Say Hi"),
              onPressed: () {
                print("Say Hello");
              },
            ),
            selected: true,
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedRadioTile,
            title: Text("Radio 2"),
            subtitle: Text("Radio 2 Subtitle"),
            onChanged: (val) {
              setSelectedRadioTile(val as int);
            },
            activeColor: Colors.red,
            secondary: OutlineButton(
              child: Text("Say Hi"),
              onPressed: () {
                print("Say Hello");
              },
            ),
            selected: false,
          ),
        ],
      ),
    );
  }
}
