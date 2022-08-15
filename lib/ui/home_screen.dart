import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab()
      ],
    );
  }
}
