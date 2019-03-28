import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';

class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> leftCategoryList = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  void _getCategory() async {
    print('开始加载分类页信息....');
    await request(GET_CATEGORY).then((val) {
      var data = jsonDecode(val.toString());
      CategoryModel leftCategory = CategoryModel.fromJson(data);
      setState(() {
        leftCategoryList = leftCategory.data;
        _provideChildCateGory(listIndex);
      });
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': '1',
    };

    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getCategoryGoodsList(goodsList.data);
    });
  }

  void _provideChildCateGory(index){
    var childList = leftCategoryList[index].bxMallSubDto;
    Provide.value<ChildCategory>(context).getChildCategory(childList,childList[0].mallCategoryId);
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        _provideChildCateGory(index);
        _getGoodsList(categoryId:leftCategoryList[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(
          left: 10,
          top: 20,
        ),
        decoration: BoxDecoration(
            color: index == listIndex ? Color.fromRGBO(240, 240, 240, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Text(
          leftCategoryList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(color: Colors.black12, width: 1))),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
          itemCount: leftCategoryList.length,
        ),
      ),
    );
  }
}
