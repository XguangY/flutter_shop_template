import 'package:flutter/material.dart';
import '../service/service_method.dart';
// 引入轮播插件
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

// 引入屏幕适配插件
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); // 顶部轮播组件数
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
              ],
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}

// swiper 封装
class SwiperDiy extends StatelessWidget {
  // 接受参数
  final List swiperDataList;
  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length, // 轮播item数量
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
