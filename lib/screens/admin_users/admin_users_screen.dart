import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/common/custom_drawe/custom_drawer.dart';
import 'package:supermercado_virtual/models/admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('Usuários'),
          centerTitle: true,
        ),
        body: Consumer<AdminUsersManager>(
          builder: (_, adminUsersManager, __) {
            return AlphabetListScrollView(
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    adminUsersManager.users[index].name,
                    style: TextStyle(
                        // retornando a altura de cada item
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    adminUsersManager.users[index].email,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              // para a cor da letra selecionada
              highlightTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              // retornando a altura de cada item
              indexedHeight: (index) => 80,
              // para a letra ao lado ir acompanhando os contatos
              showPreview: true,
              // toda a lista de nomes para gerar as letras na lateral
              strList: adminUsersManager.names,
            );
          },
        ));
  }
}
