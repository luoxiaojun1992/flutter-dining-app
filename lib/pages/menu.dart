import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';

class MenuPage extends BasePage {
  MenuPage({Key key, String title}) : super(key: key, title: title);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _searchFoodName = '';

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
            '已点菜名：' + _selectedFoodNames.join('、'),
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
                }),
          ],
        );
      },
    );
  }

  _fetchMenu(BuildContext context, int index) {
    List<Map<String, dynamic>> menu = [
      {
        'name': '毛血旺',
        'id': 1,
      },
      {
        'name': '酸菜鱼片',
        'id': 2,
      },
      {
        'name': '干锅童子鸡',
        'id': 3,
      },
      {
        'name': '熏鱼',
        'id': 4,
      },
      {
        'name': '清炒菠菜',
        'id': 5,
      },
      {
        'name': '香椿炒鹅蛋',
        'id': 6,
      },
      {
        'name': '凉拌海蜇皮',
        'id': 7,
      },
    ];

    if (index < menu.length) {
      return ListTile(
        title: FlatButton(
          child: Text(menu[index]['name']),
          onPressed: () {
            _selectFood(context, menu[index]['name'], menu[index]['id']);
          },
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            width: 200.00,
            height: 500.00,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: '菜名',
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (String foodName) {
                      setState(() {
                        _searchFoodName = foodName;
                      });
                    },
                  );
                } else {
                  return _fetchMenu(context, index - 1);
                }
              },
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
