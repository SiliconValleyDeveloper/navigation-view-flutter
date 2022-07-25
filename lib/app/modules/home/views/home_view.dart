
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nav_view/app/modules/home/views/createComplexDrawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        drawer: CreateComplexNav(),

        // backgroundColor: Colorz.compexDrawerCanvasColor,
        body: body());
  }

  appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'NavView',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Widget body() {
    return Center(
      child: Text('Nav View'),
    );
  }
}
