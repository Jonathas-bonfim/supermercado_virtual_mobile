import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supermercado_virtual/models/section.dart';
import 'package:supermercado_virtual/screens/home/components/item_tile.dart';
import 'package:supermercado_virtual/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);

  final Section section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            // para ocupar o mínimo de espaço possível para não ser a lista infinita
            shrinkWrap: true,
            // Quantidades de unidades na horizontal
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return ItemTile(
                section.items[index],
              );
            },
            staggeredTileBuilder: (index) =>
                // verificando se é par ou impar para definir a altura
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            //
            mainAxisSpacing: 4,
            // espaçamento cruzado
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
