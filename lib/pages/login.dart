import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';

class LoginPage extends BasePage {
  LoginPage({Key key, String title}) : super(key: key, title: title);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.00,
        height: 500.00,
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: '邀请码',
              ),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              color: Colors.purple,
              child: Text('提交'),
              onPressed: () {
                //todo
              },
            )
          ],
        ),
      ),
    );
  }
}
