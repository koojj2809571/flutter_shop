import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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

  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){},
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow(){
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(floorGoodsList[0]),
          Column(
            children: <Widget>[
              _goodsItem(floorGoodsList[1]),
              _goodsItem(floorGoodsList[2]),
            ],
          )
        ],
      ),
    );
  }

  Widget _otherRow(){
    return Container(
      child: Row(
        children: <Widget>[
          _goodsItem(floorGoodsList[3]),
          _goodsItem(floorGoodsList[4]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherRow(),
        ],
      ),
    );
  }
}