import 'package:flutter/material.dart';

class PageDetails extends StatelessWidget{

  final String goodsId;

  PageDetails(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品ID是：$goodsId'),
      ),
    );
  }
}