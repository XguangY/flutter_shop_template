import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('获取去数据'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: jike,
              child: Text('请求数据'),
            ),
            Text(showText),
          ],
        )),
      ),
    );
  }

  // 调用
  void jike() {
    getHttp().then((val) {
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  // 数据请求方法
  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response =
          await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(response.data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
