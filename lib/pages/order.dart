import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';

class OrderPage extends BasePage {
  OrderPage({Key key, String title}) : super(key: key, title: title);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  _fetchOrderedFoods() {
    return <Widget>[
      ListTile(
        title: Text(
          '毛血旺(张三)',
          textAlign: TextAlign.center,
        ),
      ),
      ListTile(
        title: Text(
          '酸菜鱼片(李四)',
          textAlign: TextAlign.center,
        ),
      ),
      ListTile(
        title: Text(
          '干锅童子鸡(小明)',
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Container(
          height: 500.00,
          child: ListView(
            children: _fetchOrderedFoods(),
          )),
    );
  }
}
