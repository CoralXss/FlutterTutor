import 'package:flutter/material.dart';

void main() {
  runApp(LearningEntry());
}

class LearningEntry extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter 学习",
      theme: ThemeData(
          primaryColor: Colors.green
      ),
      home: new EntryHome(),
    );
  }

}

class _EntryHomeState extends State<EntryHome> {
  // 可变更状态的列表组件
  List<Widget> widgets = [];

  List<_TutorData> datas = [];

  @override
  void initState() {
    super.initState();
    _setListData();
    _setListWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 学习"),
      ),
      body: new ListView(children: widgets),
    );
  }

  _setListWidgets() {
    datas.forEach((e) {
      // print("render: " + e._title + ", ${e._isExpanded}");
      widgets.add(
          new GestureDetector(  // 给列表添加手势
            behavior: HitTestBehavior.opaque,
            child: new TutorItem(data: e),
            onTap: () {
              print('Row tapped:' + e._title);
            },
          )
      );
    });
    return widgets;
  }

  // _notifyDataSetChanged(_TutorData clickedData) {
  //   datas.forEach((element) {
  //     print('ee: ${element._title} , ${clickedData._title} ');
  //     element._isExpanded = (element._title == clickedData._title);
  //   });
  //   print('data: $datas');
  //
  //   _setListWidgets();
  //
  //   // widgets = new List.from(widgets);
  // }

  // 后期使用 json 进行解析
  _setListData() {
    datas = [];
    for (int i = 0; i < 15; i++) {
      _TutorData t = new _TutorData();
      t._title = "Chapter $i";
      t._description = "Description $i";
      t._isExpanded = i == 0;
      datas.add(t);
    }
    return datas;
  }

}

class EntryHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EntryHomeState();
}

class _TutorData {

  int _id;

  String _title;

  String _description;

  bool _isExpanded;

  @override
  String toString() {
    return _title + ": $_isExpanded";
  }
}

class _TutorItemState extends State<TutorItem> {

  // VoidCallback onClick;  // 子Widget的事件如何传递给外层控件呢？比如展开折叠事件。

  _TutorData data;

  _expand() {
    setState(() {
      data._isExpanded = !data._isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {

    print('$data.title, $data.isExpanded');

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Container(
          padding: EdgeInsets.only(left: 12.0, top: 4.0, bottom: 4.0, right: 12.0),
          child: new Row(
            children: [
              new Expanded(   // weight = 0，占满剩余空间
                child: new Text(
                  '${data._title}',
                  style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              new IconButton(
                icon: new Icon(data._isExpanded ? Icons.expand_more : Icons.expand_less),
                color: Colors.grey[500],
                onPressed: _expand,
              ),
            ],
          ),
          // decoration: new BoxDecoration(   // 等同于 ShapeDrawable
          //   color: Colors.lime[700],
          // ),
        ),

        _buildExpandWidget(),

        new Divider(
          height: 1.0,
          color: Colors.black26,
        ),
      ],
    );
  }

  _buildExpandWidget() {
    if (data._isExpanded) {
      return new Container(
        padding: EdgeInsets.only(left: 12.0, top: 0.0, right: 12.0, bottom: 12.0),
        child: new Text(
          '${data._description}',
          textAlign: TextAlign.left,
          softWrap: true,      // 自动换行
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black26,
          ),
        ),
      );
    } else {
      return new Container(height: 0.0, width: 0.0,);
    }
  }
}

class TutorItem extends StatefulWidget {

  // final String title;
  //
  // final String description;
  //
  // final bool isExpanded;

  final _TutorData data;

  // TutorItem({Key key, this.title, this.description, this.isExpanded}) : super(key: key);

  TutorItem({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _TutorItemState s = new _TutorItemState();
    // s.title = title;
    // s.description = description;
    // s.isExpanded = isExpanded;
    s.data = data;

    return s;
  }

}