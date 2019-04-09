import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/page_details.dart';

Handler pageDetailHandler = new Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goods id is: $goodsId');
    return PageDetails(goodsId);
  }
);