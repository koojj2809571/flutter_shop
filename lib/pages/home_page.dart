import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../service/service_method.dart';
import 'dart:convert';

import '../widget/homepage/swiper_diy.dart';
import '../widget/homepage/top_navigator.dart';
import '../widget/homepage/ad_banner.dart';
import '../widget/homepage/floor_widget.dart';
import '../widget/homepage/leader_phone.dart';
import '../widget/homepage/recommed.dart';
import '../router/application.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '还没有请求导数据';
  final formData = {'lon': '115.02932', 'lat': '35.76189'};
  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footKey = new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/details?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
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
              List<Map> navigatorList = (dataHead['category'] as List).cast();
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

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.black87,
                  showMore: true,
                  noMoreText: "",
                  moreInfo: '加载中...',
                  loadReadyText: '上拉加载...',
                ),
                loadMore: () async {
                  print('加载中......');
                  var formData = {'page': page};
                  request('homePageBelowConten', formData: formData)
                      .then((val) {
                    var data = jsonDecode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiper),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    Recommend(recommendList: recommendList),
                    FloorTitle(titleImage: floor1Title),
                    FloorContent(floorGoodsList: floor1List),
                    FloorTitle(titleImage: floor2Title),
                    FloorContent(floorGoodsList: floor2List),
                    FloorTitle(titleImage: floor3Title),
                    FloorContent(floorGoodsList: floor3List),
                    _hotGoods(),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中.....'),
              );
            }
          },
          future: request(HOME_PAGE_CONTENT, formData: formData),
        ),
      ),
    );
  }
}
