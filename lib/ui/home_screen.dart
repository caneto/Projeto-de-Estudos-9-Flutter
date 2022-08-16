import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/category_tab.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
         body: HomeTab(),
         drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          body: CategoryTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
