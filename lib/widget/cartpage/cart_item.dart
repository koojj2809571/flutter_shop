import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../model/cart_info.dart';
import 'cart_count.dart';
import '../../provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel itemInfo;

  CartItem(this.itemInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
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
          _cartCheckButton(context, itemInfo),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context, itemInfo),
        ],
      ),
    );
  }

  Widget _cartCheckButton(context, CartInfoModel item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeItemCheckState(item);
        },
        activeColor: Colors.pink,
      ),
    );
  }

  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.black12,
      )),
      child: Image.network(itemInfo.images),
    );
  }

  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(itemInfo.goodsName),
          CartCount(itemInfo),
        ],
      ),
    );
  }

  Widget _cartPrice(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('¥ ${itemInfo.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteSingleGoods(item.goodsId);
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
