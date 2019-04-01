import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';
  String subId = '';
  int page = 1;
  String noMreText = '';

  getChildCategory(List<BxMallSubDto> list, String id){
    page = 1;
    noMreText = '';
    categoryId = id;
    childIndex = 0;
    childCategoryList.clear();
    BxMallSubDto itemAll = new BxMallSubDto(mallCategoryId: '00',mallSubId: '',comments: 'null',mallSubName: '全部');
    childCategoryList..add(itemAll)..addAll(list);
    notifyListeners();
  }

  changeChildIndex(index,String id){
    page = 1;
    noMreText = '';
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  addPage(){
    page++;
  }

  changeNoMoreText(String text){
    noMreText = text;
    notifyListeners();
  }
}