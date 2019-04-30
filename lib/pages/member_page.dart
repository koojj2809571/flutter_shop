import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _lists()
        ],
      ),
    );
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(350),
            margin: EdgeInsets.only(top: 40),
            child: ClipOval(
              child: Image.network(
                  'https://avatars3.githubusercontent.com/u/26473041?s=40&v=4'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '去去去去去去',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myListTile(IconData leadIcon,String titleText,IconData rightIcon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(leadIcon),
        title: Text(titleText),
        trailing: Icon(rightIcon),
      ),
    );
  }
  
  Widget _lists(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile(Icons.blur_circular, '领取优惠卷', Icons.keyboard_arrow_right),
          _myListTile(Icons.blur_circular, '已领取优惠卷', Icons.keyboard_arrow_right),
          _myListTile(Icons.blur_circular, '地址管理', Icons.keyboard_arrow_right),
          _myListTile(Icons.blur_circular, '客服电话', Icons.keyboard_arrow_right),
          _myListTile(Icons.blur_circular, '关于我们', Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}
