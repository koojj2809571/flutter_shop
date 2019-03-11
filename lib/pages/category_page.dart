import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget{
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>{

  void _getCategory() async {
    print('开始加载分类页信息....');
    await request(GET_CATEGORY).then((val){
      var data = jsonDecode(val.toString());
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }
}