import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  CartInfoModel cartInfo;

  CartCount(this.cartInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context) {
    bool canReduce = cartInfo.count > 1;
    return InkWell(
      onTap: () {
        if(canReduce) {
          Provide.value<CartProvide>(context).changeGoodsCount(cartInfo, -1);
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: canReduce ? Colors.white : Colors.black26,
          border: Border(
            right: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(canReduce ? '-' : ''),
      ),
    );
  }

  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).changeGoodsCount(cartInfo, 1);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${cartInfo.count}'),
    );
  }
}
