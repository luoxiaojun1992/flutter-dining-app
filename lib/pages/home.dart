import 'package:flutter/material.dart';
import 'package:dining/pages/base.dart';
import 'package:dining/pages/menu.dart';
import 'package:dining/pages/order.dart';
import 'package:dining/pages/login.dart';

class MyHomePage extends BasePage {
  MyHomePage({Key key, String title}) : super(key: key, title: title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BasePage> _pageList = [
    MenuPage(
      title: '我的菜单',
    ),
    OrderPage(
      title: '全部已点',
    ),
    LoginPage(
      title: '登录',
    ),
  ];

  List<String> _pageTitles = [
    '我的菜单',
    '全部已点',
    '登录',
  ];

  int _pageIndex = 0;

  _getPage(int pageIndex) {
    return IndexedStack(
      index: pageIndex,
      children: _pageList,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_pageTitles[_pageIndex]),
      ),
      body: _getPage(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text(
              '我的菜单',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text(
              '全部已点',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            title: Text(
              '登录',
            ),
          ),
        ],
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
