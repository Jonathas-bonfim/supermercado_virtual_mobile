import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/home_manager.dart';
import 'package:supermercado_virtual/models/section.dart';
import 'package:supermercado_virtual/screens/home/components/add_tile_widget.dart';
import 'package:supermercado_virtual/screens/home/components/item_tile.dart';
import 'package:supermercado_virtual/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // contex (não utilizado) e o index
              itemBuilder: (_, index) {
                // caso a quantidade de itens seja menor que que o tamanho de itens da lista
                // verificando se está editando ou não
                if (index < section.items.length)
                  // AspectRatio força a imagem a ficar quadrada
                  return ItemTile(section.items[index]);
                else
                  return AddTileWidget();
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: homeManager.editing
                  ? section.items.length + 1
                  : section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
