import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/details_info.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context,child,value){
      var left = Provide.value<DetailsInfoProvide>(context).isLeft;
      var right = Provide.value<DetailsInfoProvide>(context).isRight;
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: <Widget>[
            _myTabBar(context, true, left),
            _myTabBar(context, false, right),
          ],
        ),
      );
    });
  }

  Widget _myTabBar(BuildContext context, bool isLeft,bool isSelected) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight( isLeft ? 'left' : 'right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: isSelected ? 2 : 1,
              color: isSelected ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          isLeft ? '详情' : '评论',
          style: TextStyle(
            color: isSelected ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
