import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/services_url.dart';

const String HOME_PAGE_CONTENT = 'homePageContent'; //获取首页主题内容
const String HOME_PAGE_BELOW_CONTENT = 'homePageBelowConten'; //获取首页火爆专区内容
const String GET_CATEGORY = 'getCategory'; //获取首页火爆专区内容

Future request(url, {formData}) async {
  try {
    print('开始获取数据.......................');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if(formData == null){
      response = await dio.post(servicePath[url]);
    }else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常！！！');
    }
  } catch (e) {
    print('ERROR:======>$e');
  }
}
