import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List<BxMallSubDto> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      list = childCategory.childCategoryList;
      return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        ),
      );
    });
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex
        ? true
        : false);
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: InkWell(
        onTap: () {
          Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
          _getGoodsList(item.mallSubId);
        },
        child: Text(
          list[index].mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black26,
            fontWeight: isClick ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': '1',
    };

    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(goodsList.data);
      }
    });
  }
}
