import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root = '/';
  static String detailsPage = '/details';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR===>ROUTEW WAS NOT FOUND!!!!!!');
      }
    );

    router.define(detailsPage, handler: pageDetailHandler);
  }
}