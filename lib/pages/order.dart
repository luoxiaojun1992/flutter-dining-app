import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget
{
  OrderPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
{
  @override
  Widget build(BuildContext context) {
    return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          height: 500.00,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  '毛血旺',
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: Text(
                  '酸菜鱼片',
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: Text(
                  '干锅童子鸡',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ),
      );
  }
}
