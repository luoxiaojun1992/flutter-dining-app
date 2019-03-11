import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';

class OrderPage extends BasePage {
  OrderPage({Key key, String title}) : super(key: key, title: title);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  _fetchOrderedFood(index) {
    List<Map<String, dynamic>> orderedFoods = [
      {
        'name': '毛血旺(张三)',
      },
      {'name': '酸菜鱼片(李四)'},
      {'name': '干锅童子鸡(小明)'},
    ];

    if (index < orderedFoods.length) {
      return ListTile(
        title: Text(
          orderedFoods[index]['name'],
          textAlign: TextAlign.center,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Container(
          height: 500.00,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _fetchOrderedFood(index);
            },
          )),
    );
  }
}
