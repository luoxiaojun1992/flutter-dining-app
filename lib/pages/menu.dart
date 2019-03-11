import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Set<int> _selectedFoodIds = {};
  Set<String> _selectedFoodNames = {};

  _selectFood(BuildContext context, String foodName, int foodId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '请确认菜名',
            textAlign: TextAlign.center,
          ),
          content: Text(
            foodName,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'),
                onPressed: () {
                  _selectedFoodIds.add(foodId);
                  _selectedFoodNames.add(foodName);
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  _submitFood(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '确认提交',
            textAlign: TextAlign.center,
          ),
          content: Text(
            _selectedFoodNames.join('、'),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'),
                onPressed: () {
                  //todo submit foods id
                  _selectedFoodIds.clear();
                  _selectedFoodNames.clear();
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            height: 500.00,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: FlatButton(
                    child: Text('毛血旺'),
                    onPressed: () {
                      _selectFood(context, '毛血旺', 1);
                    },
                  ),
                ),
                ListTile(
                  title: FlatButton(
                    child: Text('酸菜鱼片'),
                    onPressed: () {
                      _selectFood(context, '酸菜鱼片', 2);
                    },
                  ),
                ),
                ListTile(
                  title: FlatButton(
                    child: Text('干锅童子鸡'),
                    onPressed: () {
                      _selectFood(context, '干锅童子鸡', 3);
                    },
                  ),
                ),
                ListTile(
                  title: FlatButton(
                    child: Text('凉拌海蜇皮'),
                    onPressed: () {
                      _selectFood(context, '凉拌海蜇皮', 4);
                    },
                  ),
                ),
                ListTile(
                  title: FlatButton(
                    child: Text('清炒菠菜'),
                    onPressed: () {
                      _selectFood(context, '清炒菠菜', 5);
                    },
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitFood(context);
        },
        tooltip: '提交',
        child: Icon(Icons.add),
      ),
    );
  }
}
