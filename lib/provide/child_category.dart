import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(list){
    childCategoryList = list;
    notifyListeners();
  }
}