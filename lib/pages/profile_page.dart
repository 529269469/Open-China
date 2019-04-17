import 'package:flutter/material.dart';
import 'package:open_china/constants/constants.dart' show AppColors;
import 'package:open_china/pages/login_web_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List memuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    _showUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return buildHeader();
          }
          index -= 1;
          return ListTile(
            leading: Icon(memuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  void _showUserInfo() {}

  void _login() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
  }

  Container buildHeader() {
    return Container(
      height: 150,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          //头像
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffffffff), width: 2),
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/ic_avatar_default.png'),
                        fit: BoxFit.cover)),
              ),
              onTap: () {
                //执行登录
                _login();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '点击头像登录',
              style: TextStyle(color: Color(0xffffffff)),
            )
          ],
        ),
      ),
    );
  }
}
