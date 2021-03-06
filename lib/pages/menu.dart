import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';
import 'package:dio/dio.dart';
import 'package:dining/components/view/dialog.dart';
import 'package:dining/components/basic/auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:dining/components/basic/config.dart';

class MenuPage extends BasePage {
  MenuPage({Key key, String title}) : super(key: key, title: title);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _searchFoodName = '';

  List<dynamic> _menu = [];

  Set<int> _selectedFoodIds = {};
  Set<String> _selectedFoodNames = {};

  _selectFood(BuildContext context, String foodName, int foodId) {
    alert(
      '请确认菜名',
      foodName,
      context,
      okCallback: () {
        _selectedFoodIds.add(foodId);
        _selectedFoodNames.add(foodName);
        Navigator.of(context).pop();
      },
    );
  }

  _submitFoodData(
      BuildContext context, Set<int> foodsIds, Set<String> foodNames) async {
    if (foodsIds.length <= 0) {
      return;
    }

    String _foodsNamesStr = foodNames.join(',');

    try {
      Map<String, dynamic> headers = {};
      if (await Auth.getToken() != null) {
        headers['Authorization'] = await Auth.getToken();
      }
      Response response = await Dio().post(
        Config.fetch('api_gateway') + '/dining/order',
        data: {'ids': foodsIds.toList()},
        options: Options(
          responseType: ResponseType.json,
          headers: headers,
        ),
      );

      dynamic jsonData = response.data;
      if (jsonData['code'] == 0) {
        _selectedFoodIds.clear();
        _selectedFoodNames.clear();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '提交成功',
                textAlign: TextAlign.center,
              ),
              content: Text(
                '提交成功:' + _foodsNamesStr,
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
                '提交失败:' + _foodsNamesStr,
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
    } catch (e) {
      String errStr = _foodsNamesStr;
      if (e.response != null && e.response.statusCode == 401) {
        errStr = '请先登陆';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '提交成功',
              textAlign: TextAlign.center,
            ),
            content: Text(
              '提交失败:' + errStr,
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
                  _submitFoodData(
                      context, _selectedFoodIds, _selectedFoodNames);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  _fetchMenuData(int page) async {
    Response response =
        await Dio().get(Config.fetch('api_gateway') + '/dining/menu',
            queryParameters: {
              'page': page.toString(),
              'keyword': _searchFoodName,
            },
            options: Options(responseType: ResponseType.json));

    dynamic jsonData = response.data;
    if (jsonData['code'] == 0 && jsonData['data'].length > 0) {
      if (mounted) {
        setState(() {
          jsonData['data'].forEach((dynamic v) {
            _menu.add(v);
          });
        });
      }
    }
  }

  _fetchMenu(BuildContext context, int index) {
    if (index < _menu.length) {
      return ListTile(
        title: FlatButton(
          child: Text(_menu[index]['name']),
          onPressed: () {
            _selectFood(context, _menu[index]['name'], _menu[index]['id']);
          },
        ),
      );
    } else {
      _fetchMenuData((index / 10).ceil() + 1);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 600.00,
          child: LiquidPullToRefresh(onRefresh: () async {
            setState(() {
              _menu = [];
            });
          }, child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Center(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '菜名',
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (String foodName) {
                        setState(() {
                          _searchFoodName = foodName;
                          _menu = [];
                        });
                      },
                    ),
                    width: 200.00,
                  ),
                );
              } else {
                return _fetchMenu(context, index - 1);
              }
            },
          ))),
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
