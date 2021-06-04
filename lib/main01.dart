import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(new MyApp());
}
/// 示例知识点：列表、状态更新、点击事件
/// 本示例创建一个Material APP。Material是一种标准的移动端和web端的视觉设计语言。 Flutter提供了一套丰富的Material widgets。
/// 1. flutter 中一切皆为 Widget，包括对齐（alignment）、填充（padding）和布局（layout）。
/// 2. Scaffold 为 MT Lib 中的一个 widget，提供了默认的导航栏、标题 和包含 主屏幕 widget 树的 body 属性。
/// 3. 如果应用程序正在运行，请使用热重载按钮 (⚡️) 更新正在运行的应用程序
/// 4.「有状态的组件 Stateful widget」： StatefulWidget + State
/// 5. 创建一个无限滚动的 ListView
/// 6. 添加交互：为每一行添加一个可点击的心形 ❤️ 图标，点击进行收藏或移除收藏夹。
///    setState() 更新状态，会重新为 State 对象触发 build() 方法，使 UI 更新。【响应式】
/// 7. 导航到新页面：添加一个显示收藏夹内容的新页面（在Flutter中称为路由(route)）。
/// 8. 使用主题更改 UI：通过配置ThemeData类轻松更改应用程序的主题。
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final wordPair = new WordPair.random();
    
    return new MaterialApp(
      title: "Welcome to Flutter",
      theme: new ThemeData(
        primaryColor: Colors.green
      ),
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('Welcome to Flutter'),
      //   ),
      //   body: new Center(
      //     // child: new Text('Hello World'),
      //     // child: new Text(wordPair.asPascalCase),
      //     child: new RandomWords(),  // 每次热重载会生成新的单词对
      //   ),
      // ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

/// 1. 保存随着用户滚动而无限增长的生成的单词对，以及喜欢的单词对
/// 3. 用户通过重复点击心形 ❤️ 图标来将它们从列表中添加或删除
class RandomWordsState extends State<RandomWords> {
  // 列表数据源
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // 收餐夹数据
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return new ListTile(  // 列表行组件
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(   // 为每行添加一个❤️ 图标
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {      // 通知框架状态已改变，setState() 会重新为 State 对象触发 build() 方法，使 UI 更新
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1~4 步
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context) {
            final tiles = _saved.map((pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            });
            final divided = ListTile.divideTiles(  // 每个ListTile之间添加1像素的分割线
              context: context,
              tiles: tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
              ),
              body: new ListView(children: divided),  // 收藏页面数据源组件，路由直接传值，直接传构造好了的组件数据过去。
            );
          },
      ),
    );
  }

}