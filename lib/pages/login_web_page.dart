import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:open_china/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_china/utils/data_utils.dart';
import 'package:open_china/utils/net_utils.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      print('_flutterWebviewPlugin.onUrlChanged:$url');
      if(mounted){
        setState(() {
          isLoading=false;
        });
      }
      if(url!=null&&url.length>0&&url.contains('?code=')){
        String code=url.split('?')[1].split('&')[0].split('=')[1];
        Map<String,dynamic> params=Map<String,dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data){
          print('$data');
          if(data!=null){
            Map<String,dynamic> map=json.decode(data);
            if(map!=null&&map.isNotEmpty){
              DataUtils.saveLoginInfo(map);
            }
          }
        });

      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBaeTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(color: Color(AppColors.APPBAR)),
      ),
    ];
    if (isLoading) {
      _appBaeTitle.add(SizedBox(
        width: 10,
      ));
      _appBaeTitle.add(CupertinoActivityIndicator());
    }
    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBaeTitle,
        ),
      ),
      withJavascript: true,//允许执行js
      withLocalStorage: true,//允许本地存储
      withZoom: true,//允许网页缩放
    );
  }
}
