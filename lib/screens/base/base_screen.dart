import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer_header.dart';
import 'package:supermercado_virtual/models/page_manager.dart';
import 'package:supermercado_virtual/screens/login/login_screen.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home 2'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home 3'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home 4'),
            ),
          ),
        ],
      ),
    );
  }
}
