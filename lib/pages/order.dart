import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';
import 'package:dio/dio.dart';

class OrderPage extends BasePage {
  OrderPage({Key key, String title}) : super(key: key, title: title);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _searchKeyword = '';

  List<dynamic> _ordered = [];

  _fetchOrderdData(int page) async {
    Response response = await Dio().get(
      'http://127.0.0.1:9501/dining/ordered',
      queryParameters: {'page': page.toString(), 'keyword': _searchKeyword},
      options: Options(responseType: ResponseType.json),
    );

    dynamic jsonData = response.data;
    if (jsonData['code'] == 0 && jsonData['data'].length > 0) {
      setState(() {
        jsonData['data'].forEach((dynamic v) {
          _ordered.add(v);
        });
      });
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
    return Center(
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
                  labelText: '搜索',
                ),
                textAlign: TextAlign.center,
                onChanged: (String keyword) {
                  setState(() {
                    _searchKeyword = keyword;
                    _ordered = [];
                  });
                },
              );
            } else {
              return _fetchOrderedFood(index - 1);
            }
          },
        )
      ),
    );
  }
}
