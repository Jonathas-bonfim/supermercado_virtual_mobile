import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    // obtendo a página atual, os valores da página são atribuídos na custom_drawer
    //sempre utilizar o Whatc no lugar do read quando for alterar o estado.
    final int curPage = context.watch<PageManager>().page;

    //pegando a cor primária para colocar no menu selecionado
    final Color primaryColor = Theme.of(context).primaryColor;

    // mostra onde selecionamos
    return InkWell(
      onTap: () {
        //alternando a página quando clicar.
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                //obtendo a cor dependendo da cor atual
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16,
               color: curPage == page ? primaryColor : Colors.grey[700]
               ),
            ),
          ],
        ),
      ),
    );
  }
}
