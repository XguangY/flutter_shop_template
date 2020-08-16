import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎点餐';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('点餐单'),
        ),
        // SingleChildScrollView 是一个滚动组件，可以解决手机键盘弹起导致的越界问题
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            child: Column(
              children: <Widget>[
                // 文本框组件
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0), // 设置边距功能
                    labelText: '点餐类型',
                    helperText: '请输入你的点餐类型',
                  ),
                  autofocus: false, // 取消自动获取焦点功能
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('选择完毕'),
                ),
                Text(showText,
                    overflow: TextOverflow.ellipsis, // 设置超出容器效果
                    maxLines: 1)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 按钮点击事件处理
  void _choiceAction() {
    print('开始输入你选择的类型...');
    if (typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('点餐的类型不能为空'),
        ),
      );
    } else {
      postHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }
}

Future postHttp(String typeText) async {
  try {
    Response response;
    var data = {'name': typeText};
    response = await Dio().post(
      'https://www.easy-mock.com/mock/5f38f8a65f7d57560f083097/shop/post_diancan',
      queryParameters: data,
    );
    return response.data;
  } catch (e) {
    print(e);
  }
}
