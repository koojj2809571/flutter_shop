import 'package:flutter/material.dart';
import '../model/category_goods_list_model.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getCategoryGoodsList(List<CategoryListData> list){
    goodsList = list;
    notifyListeners();
  }
}