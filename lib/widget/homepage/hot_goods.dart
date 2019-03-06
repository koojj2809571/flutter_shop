

//火爆商品专区
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

class HotGoods extends StatefulWidget{
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods>{

  @override
  void initState() {
    request(HOME_PAGE_BELOW_CONTENT,formData: 0).then((val){
      print('获取到的数据$val');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('111111111111111');
  }
}