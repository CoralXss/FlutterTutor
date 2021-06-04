import 'package:flutter/material.dart';

// 引入第三方库
import 'package:english_words/english_words.dart';

// 应用入口
void main() => runApp(new MyCounter());

// 应用的根组件
class MyCounter extends StatelessWidget {  // 无状态的组件，生命周期内状态不可变

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 应用名称
      title: "MyCounter",
      // 应用主题
      theme: new ThemeData(
        primarySwatch: Colors.yellow
      ),
      // 应用首页路由
      home: new MyCounterHomePage(title: 'Flutter Counter Demo Home Page',),
    );
  }
}

class NewRoute extends StatelessWidget { // 一个新的路由页面

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('New Route'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }

  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    return super.createElement();
  }
}

class MyCounterHomePage extends StatefulWidget {   // 有状态的组件，生命周期内状态可变

  MyCounterHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  StatefulElement createElement() {
    // TODO: implement createElement
    return super.createElement();
  }

  @override
  State<StatefulWidget> createState() => new _MyCounterHomePageState();
}

class _MyCounterHomePageState extends State<MyCounterHomePage> {  // 数据更新 状态组件

  int _counter = 0;

  void _incrementCounter() {
    setState(() {    // 通知 flutter 框架，有状态发送了变更，收到后会执行 build 方法根据新的状态重新构建界面
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(  // Material 库中的页面脚手架，
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have clicked the button this many times: '),
            new Text('$_counter', style: Theme.of(context).textTheme.headline4, ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) {  // MaterialPageRoute
                    return NewRoute();   // 点击按钮，路由到一个新的页面
                  }));
              },
            ),
            RandomWordsWidget()
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

}