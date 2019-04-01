import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryGoodsList extends StatefulWidget {
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footKey = new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            scrollController.jumpTo(0);
          }
        }catch(e){
          print('进入页面第一次初始化：$e');
        }
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
                width: ScreenUtil().setWidth(570),
                child: EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    key: _footKey,
                    bgColor: Colors.transparent,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.black87,
                    showMore: true,
                    noMoreText: Provide.value<ChildCategory>(context).noMreText,
                    moreInfo: '加载中...',
                    loadReadyText: '上拉加载...',
                  ),
                  loadMore: () async {
                    print('加载中......');
                    _geMoreList();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: data.goodsList.length,
                    itemBuilder: (context, index) {
                      return _listItemWidget(data.goodsList, index);
                    },
                  ),
                )),
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

  void _geMoreList() async {
    Provide.value<ChildCategory>(context).addPage();

    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page,
    };

    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Provide.value<ChildCategory>(context)
            .changeNoMoreText('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreGoodsList(goodsList.data);
      }
    });
  }
}
