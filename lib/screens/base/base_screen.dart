import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer.dart';
import 'package:supermercado_virtual/models/page_manager.dart';
import 'package:supermercado_virtual/models/user_manager.dart';
import 'package:supermercado_virtual/screens/admin_users/admin_users_screen.dart';
import 'package:supermercado_virtual/screens/home/home_screen.dart';
import 'package:supermercado_virtual/screens/products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Pedidos'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
