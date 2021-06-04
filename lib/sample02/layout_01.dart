import 'package:flutter/material.dart';

/// Demo 知识点：
/// 1. Flutter 布局机制
/// 2. 如何垂直和水平布局 widget
/// 3. 如何构建一个 Flutter 布局
/// 4. 增加交互：点击红线，不收藏变成空心 && 41 减少；重新收藏，增加计数。

void main() {
  runApp(Mylayout01());
}

class Mylayout01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(    // 水平方向布局
        children: [      // 3列组件
          new Expanded(  // 第一列：占用大量控件，使用 Expanded
            child: new Column(  // 垂直方法布局
              crossAxisAlignment: CrossAxisAlignment.start,  // 左对齐
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // new Icon(  // 原收藏 UI
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // new Text('41'),

          new FavoriteWidget(),
        ],
      ),
    );

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(context, Icons.call, 'CALL'),
          buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
        Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,   // 表示文本是否应在软换行符（如句号或逗号）直接断开。
      ),
    );

    return new MaterialApp(
      title: '构建布局-教程',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
              '构建布局-教程'
          ),
        ),
        body: new ListView(
          children: [
            new Image.asset(
              'images/lake.jpeg',
              height: 240.0,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  // 图文垂直居中 组件
  Column buildButtonColumn(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

}

/// 给收藏红心组件 添加交互
class FavoriteWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _FavoriteState();

}

class _FavoriteState extends State<FavoriteWidget> {

  bool _isCollected = true;

  int _collectCount = 100;

  void _toogleFavorite() {
    setState(() {
      if (_isCollected) {
        _collectCount -= 1;
        _isCollected = false;
      } else {
        _collectCount += 1;
        _isCollected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: new Icon(_isCollected ? Icons.star : Icons.star_border),
            color: Colors.red[500],
            onPressed: _toogleFavorite,
          ),
        ),
        // new Text('$_collectCount'),
        new SizedBox(    // 使用 SizeBox 并设置其宽度，防止不同宽度的数字宽度出现明显的'跳跃'。对比：直接使用 Text，从 100-> 99 是图标右移；用 SizeBox，就文字格式固定-1，不会出现任何位置偏移，也即是均左对齐。
          width: 24.0,
          child: new Container(
            child: new Text('$_collectCount'),
          ),
        ),
      ],
    );
  }

}