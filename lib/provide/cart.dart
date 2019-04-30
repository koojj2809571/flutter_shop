import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  final String cartInfo = 'cartInfo';

  String cartString = '[]';
  List<CartInfoModel> cartInfoList = [];
  double allPrice = 0;
  int allGoodsCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int i = 0;
    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[i]['count'] = item['count'] + 1;
        cartInfoList[i].count++;
        isHave = true;
      }
      if(item['isCheck']){
        allPrice += (cartInfoList[i].price * cartInfoList[i].count);
        allGoodsCount += cartInfoList[i].count;
      }
      i++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      allPrice += count * price;
      allGoodsCount += count;
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

  deleteSingleGoods(String goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    sp.setString(cartInfo, cartString);
    await getCartInfo();
  }

  changeItemCheckState(CartInfoModel cartItem) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    int tempIndex = 0;
    int changeIndex = 0;
    List<Map> tempList = (json.decode(sp.getString(cartInfo)) as List).cast();
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sp.setString(cartInfo, cartString);
    await getCartInfo();
  }

  changeAllCheckState(bool isAllCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    List<Map> tempList = (json.decode(cartString) as List).cast();
    tempList.forEach((item) {
      item['isCheck'] = isAllCheck;
    });
    cartString = json.encode(tempList).toString();
    sp.setString(cartInfo, cartString);
    await getCartInfo();
  }

  changeGoodsCount(CartInfoModel cartItem, int count) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        item['count'] += count;
      }
    });
    cartString = json.encode(tempList).toString();
    sp.setString(cartInfo, cartString);
    await getCartInfo();
  }

  getCartInfo() async {
    await _getCartList().then((List<Map> data) {
      List<Map> tempList = data;
      cartInfoList.clear();
      if (cartString == null) {
        cartInfoList.clear();
      } else {
        allPrice = 0;
        allGoodsCount = 0;
        isAllCheck = true;
        tempList.forEach((item) {
          if (item['isCheck']) {
            allPrice += item['count'] * item['price'];
            allGoodsCount += item['count'];
          } else {
            isAllCheck = false;
          }
          cartInfoList.add(CartInfoModel.fromJson(item));
        });
      }
      notifyListeners();
    });
  }

  Future<List<Map>> _getCartList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartInfo);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    return tempList;
  }
}
