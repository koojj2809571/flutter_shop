import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:path/path.dart';


//楼层信息
class FloorTitle extends StatelessWidget{

  final String titleImage;

  FloorTitle({Key key,this.titleImage}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(titleImage),
    );
  }
}

class FloorContent extends StatelessWidget{

  final List floorGoodsList;

  FloorContent({Key key,this.floorGoodsList}):super(key:key);

  Widget _goodsItem(Map goods,BuildContext context){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, '/details?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow(context){
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(floorGoodsList[0],context),
          Column(
            children: <Widget>[
              _goodsItem(floorGoodsList[1],context),
              _goodsItem(floorGoodsList[2],context),
            ],
          )
        ],
      ),
    );
  }

  Widget _otherRow(context){
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(floorGoodsList[3],context),
          _goodsItem(floorGoodsList[4],context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherRow(context),
        ],
      ),
    );
  }
}