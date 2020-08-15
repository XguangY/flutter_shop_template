// Material Design 是由Google推出的全新设计语言，
// 这种设计语言是为手机、平板电脑、台式机和其他平台提供一致，更广泛的外观和感觉。
import 'package:flutter/material.dart';

// 即IOS风格组件，它重现了很多经典的有IOS特性的交互和界面风格，让适用于IOS的人感觉亲切和友好。
import 'package:flutter/cupertino.dart';

// 引入四个子页面
import './cart_page.dart';
import './category_page.dart';
import './home_page.dart';
import './member_page.dart';

// 页面需要使用动态组件
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // 底部栏数据
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.home,
      ),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.search,
      ),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.shopping_cart,
      ),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.profile_circled,
      ),
      title: Text('会员中心'),
    )
  ];

  // 初始化一个页面
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  // 当前选中的页面索引
  int currentIndex = 0;
  // 当前选中的页面
  var currentPage;

  // 初始化选中页面
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[index];
          });
        },
      ),
      body: currentPage,
    );
  }
}
