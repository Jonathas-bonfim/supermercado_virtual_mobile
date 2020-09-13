import 'package:flutter/material.dart';
import 'package:supermercado_virtual/common/custom_drawe/drawer_tile.dart';
// package:supermercado_virtual
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Lista de opções
      child: ListView(
        children: <Widget>[
          DrawerTile(iconData: Icons.home, title: 'Início', page: 0,),
          DrawerTile(iconData: Icons.list, title: 'Produtos', page: 1,),
          DrawerTile(iconData: Icons.playlist_add_check, title: 'Pedidos', page: 2,),
          DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3,),
        ],
      ),
    );
  }
}