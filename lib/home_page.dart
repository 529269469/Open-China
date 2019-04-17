import 'package:flutter/material.dart';
import 'package:open_china/pages/discovery_page.dart';
import 'package:open_china/pages/news_list_page.dart';
import 'package:open_china/pages/profile_page.dart';
import 'package:open_china/pages/tweet_page.dart';
import 'package:open_china/wedgets/my_drawer.dart';
import 'package:open_china/wedgets/navigation_icon_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['咨询', '动弹', '发现', '我的'];
  List<NavigationIconView> _navigationIconView;
  var _currenindex = 0;
  PageController _pageController;

  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _navigationIconView = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_actived.png'),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_actived.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_actived.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_pressed.png'),
    ];

    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currenindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(_appBarTitle[_currenindex],style: TextStyle(color: Color(0xffffffff)),),
        ),
        body: PageView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _pages[_currenindex];
          },
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {
              _currenindex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currenindex,
          items: _navigationIconView.map((view) => view.item).toList(),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currenindex = index;
            });
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 1), curve: Curves.ease);
          },
        ),
        drawer: MyDrawer(
          headImgPath: 'assets/images/cover_img.jpg',
          menuIcons: [Icons.send,Icons.home,Icons.error,Icons.settings,],
          menuTitles: ['发布动弹','动弹小黑屋','关于','设置'],) ,
    );
  }
}
