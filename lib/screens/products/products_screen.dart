import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer.dart';
import 'package:supermercado_virtual/models/product_manager.dart';
import 'package:supermercado_virtual/screens/products/components/product_list_title.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(context: context, builder: (_) => SearchDialog());
              }),
        ],
      ),
      // item builder para ir carregando os itens de acordo com o que for rolando a tela
      body: Consumer<ProductManager>(
        builder: (_, productManage, __) {
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: productManage.allProducts.length,
              itemBuilder: (_, index) {
                return ProductListTitle(productManage.allProducts[index]);
                // Acessando a lista de produtos e atualizando em tepmo real (consumer)
              });
        },
      ),
    );
  }
}
