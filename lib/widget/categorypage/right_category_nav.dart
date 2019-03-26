import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:provide/provide.dart';

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List<BxMallSubDto> list = [];
  int clickItem;

  @override
  void initState() {
    clickItem = 0;
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
              return _rightInkWell(index);
            },
          ),
        ),
      );
    });
  }

  Widget _rightInkWell(int itemIndex) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: InkWell(
        onTap: () {
          setState(() {
            clickItem = itemIndex;
          });
        },
        child: Text(
          list[itemIndex].mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: itemIndex == clickItem ? Colors.pink : Colors.black26,
            fontWeight:
                itemIndex == clickItem ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
