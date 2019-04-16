import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import '../widget/detailspage/details_top_area.dart';

class PageDetails extends StatelessWidget {
  final String goodsId;

  PageDetails(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              child: Column(
                children: <Widget>[
                  DetailsTopArea(),
                ],
              ),
            );
          }else{
            return Text("加载中.....");
          }
        },
        future: _getBackInfo(context),
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成......');
    return '完成加载';
  }
}
