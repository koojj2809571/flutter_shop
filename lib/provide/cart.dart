import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier{

  final String cartInfo = 'cartInfo';

  String cartString = '[]';
  List<CartInfoModel> cartInfoList = [];

  save(goodsId,goodsName,count,price,images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int i = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        tempList[i]['count'] = item['count'] + 1;
        cartInfoList[i].count++;
        isHave = true;
      }
      i++;
    });

    if(!isHave){
      Map<String,dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
      };
      tempList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print('字符串================$cartString');
    print('数据================$cartInfoList');
    sp.setString(cartInfo, cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(cartInfo);
    cartInfoList = [];
    print('+++++++++++清空完成+++++++++++');

    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    cartInfoList.clear();
    if(cartString == null){
      cartInfoList.clear();
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        cartInfoList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}