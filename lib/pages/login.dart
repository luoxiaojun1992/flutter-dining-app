import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';
import 'package:dio/dio.dart';

class LoginPage extends BasePage {
  LoginPage({Key key, String title}) : super(key: key, title: title);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _code = '';

  _login(BuildContext context, String code) async {
    try {
      Response response = await Dio().post('http://127.0.0.1:9501/dining/login',
          data: {'code': code},
          options: Options(responseType: ResponseType.json));

      dynamic jsonData =response.data;
      if (jsonData['code'] == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '提交成功',
                textAlign: TextAlign.center,
              ),
              content: Text(
                jsonData['data']['token'] + '登录成功',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
                ],
              );
            },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '提交成功',
                textAlign: TextAlign.center,
              ),
              content: Text(
                '登录失败',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
                ],
              );
            },
        );
      }
    } catch (Error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '提交成功',
              textAlign: TextAlign.center,
            ),
            content: Text(
              '登录失败',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
              ],
            );
          },
      );
    }
  }

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
              onChanged: (code) {
                _code = code;
              },
            ),
            FlatButton(
              color: Colors.purple,
              child: Text('提交'),
              onPressed: () {
                _login(context, _code);
              },
            )
          ],
        ),
      ),
    );
  }
}
