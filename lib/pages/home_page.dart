import 'package:flutter/material.dart';

import '../service/service_method.dart';
import 'dart:convert';

import '../widget/homepage/swiper_diy.dart';
import '../widget/homepage/top_navigator.dart';
import '../widget/homepage/ad_banner.dart';
import '../widget/homepage/floor_widget.dart';
import '../widget/homepage/leader_phone.dart';
import '../widget/homepage/recommed.dart';
import '../widget/homepage/hot_goods.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '还没有请求导数据';

  final formData = {'lon':'115.02932','lat':'35.76189'};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              var data = jsonDecode(snapShot.data.toString());
              var dataHead = data['data'];
              List<Map> swiper = (dataHead['slides'] as List).cast();
              List<Map> navigatorList =
                  (dataHead['category'] as List).cast();
              String adPicture =
                  (dataHead['advertesPicture']['PICTURE_ADDRESS']);
              String leaderImage = (dataHead['shopInfo']['leaderImage']);
              String leaderPhone = (dataHead['shopInfo']['leaderPhone']);
              List<Map> recommendList = (dataHead['recommend'] as List).cast();
              String floor1Title = dataHead['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = dataHead['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = dataHead['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1List = (dataHead['floor1'] as List).cast();
              List<Map> floor2List = (dataHead['floor2'] as List).cast();
              List<Map> floor3List = (dataHead['floor3'] as List).cast();
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(titleImage: floor1Title),
                    FloorContent(floorGoodsList: floor1List),
                    FloorTitle(titleImage: floor2Title),
                    FloorContent(floorGoodsList: floor2List),
                    FloorTitle(titleImage: floor3Title),
                    FloorContent(floorGoodsList: floor3List),
                    HotGoods(),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中.....'),
              );
            }
          },
          future: request(HOME_PAGE_CONTENT,formData: formData),
        ),
      ),
    );
  }
}
