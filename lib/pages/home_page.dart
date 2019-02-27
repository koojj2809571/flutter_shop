import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_headers.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求导数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('访问远程数据'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('请求数据'),
                ),
                Text(showText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始向极客时间请求数据..................');
    getHttpRequest().then((val) {
      print('收到返回数据');
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttpRequest() async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get(
        "https://time.geekbang.org/serv/v1/column/newAll",
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
