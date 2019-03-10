import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '点菜app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: '请您点菜'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<int> selectedFoods = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  _selectFood(BuildContext context, String foodName, int foodId){
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
                child: Text(
                  'ok'
                ),
                onPressed: () {
                  selectedFoods.add(foodId);
                  Navigator.of(context).pop();
                }
              )
            ],
          );
        },
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
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          height: 500.00,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: FlatButton(
                  child: Text(
                    '毛血旺'
                  ),
                  onPressed: () {
                    _selectFood(context, '毛血旺', 1);
                  },
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text(
                    '酸菜鱼片'
                  ),
                  onPressed: () {
                    _selectFood(context, '酸菜鱼片', 2);
                  },
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text(
                    '干锅童子鸡'
                  ),
                  onPressed: () {
                    _selectFood(context, '干锅童子鸡', 3);
                  },
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text(
                    '凉拌海蜇皮'
                  ),
                  onPressed: () {
                    _selectFood(context, '凉拌海蜇皮', 4);
                  },
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text(
                    '清炒菠菜'
                  ),
                  onPressed: () {
                    _selectFood(context, '清炒菠菜', 5);
                  },
                ),
              ),
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  '确认提交',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  selectedFoods.join('、'),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'ok'
                    ),
                    onPressed: () {
                      //todo submit foods id
                      Navigator.of(context).pop();
                    }
                  )
                ],
              );
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
