import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:provide/provide.dart';

class CategoryGoodsList extends StatefulWidget {
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listItemWidget(data.goodsList, index);
                },
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: Text('暂时没有相关商品'),
            ),
          );
        }
      },
    );
  }

  Widget _goodsImage(List list, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(List list, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List list, index) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: ScreenUtil().setWidth(370),
        child: Row(
          children: <Widget>[
            Text(
              '价格：￥${list[index].presentPrice}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.pink,
              ),
            ),
            Text(
              '￥${list[index].oriPrice}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ));
  }

  Widget _listItemWidget(List list, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
