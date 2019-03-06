//店长电话模块
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
//    String url = 'http://jspang.com';
//    String url = 'sms:15987182704';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '异常----->url不能访问';
    }
  }
}