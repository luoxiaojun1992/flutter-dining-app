import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';
import 'package:dio/dio.dart';
import 'package:dining/components/basic/auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:dining/components/basic/config.dart';

class OrderPage extends BasePage {
  OrderPage({Key key, String title}) : super(key: key, title: title);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _searchKeyword = '';

  List<dynamic> _ordered = [];

  _fetchOrderdData(int page) async {
    try {
      Map<String, dynamic> headers = {};
      if (await Auth.getToken() != null) {
        headers['Authorization'] = await Auth.getToken();
      }
      Response response = await Dio().get(
        Config.fetch('api_gateway') + '/dining/ordered',
        queryParameters: {
          'page': page.toString(),
          'keyword': _searchKeyword,
        },
        options: Options(
          responseType: ResponseType.json,
          headers: headers,
        ),
      );

      dynamic jsonData = response.data;
      if (jsonData['code'] == 0 && jsonData['data'].length > 0) {
        setState(() {
          jsonData['data'].forEach((dynamic v) {
            _ordered.add(v);
          });
        });
      }
    } catch (e) {
      if (e.response != null && e.response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '加载失败',
                textAlign: TextAlign.center,
              ),
              content: Text(
                '请先登陆',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  _fetchOrderedFood(index) {
    if (index < _ordered.length) {
      return ListTile(
        title: Text(
          _ordered[index]['name'],
          textAlign: TextAlign.center,
        ),
      );
    } else {
      _fetchOrderdData((index / 10).ceil() + 1);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.00,
      child: LiquidPullToRefresh(onRefresh: () async {
        setState(() {
          _ordered = [];
        });
      }, child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
                child: Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '搜索',
                ),
                textAlign: TextAlign.center,
                onChanged: (String keyword) {
                  setState(() {
                    _searchKeyword = keyword;
                    _ordered = [];
                  });
                },
              ),
              width: 200.00,
            ));
          } else {
            return _fetchOrderedFood(index - 1);
          }
        },
      )),
    );
  }
}
