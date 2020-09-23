import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer.dart';
import 'package:supermercado_virtual/models/product_manager.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      // item builder para ir carregando os itens de acordo com o que for rolando a tela
      body: Consumer<ProductManager>(
        builder: (_, productManage, __) {
          return ListView.builder(
              itemCount: productManage.allProducts.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(productManage.allProducts[index].name),
                );
                // Acessando a lista de produtos e atualizando em tepmo real (consumer)
              });
        },
      ),
    );
  }
}
