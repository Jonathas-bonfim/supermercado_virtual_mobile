import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supermercado_virtual/models/home_manager.dart';
import 'package:supermercado_virtual/models/section.dart';
import 'package:supermercado_virtual/screens/home/components/add_tile_widget.dart';
import 'package:supermercado_virtual/screens/home/components/item_tile.dart';
import 'package:supermercado_virtual/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section);

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
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            // para ocupar o mínimo de espaço possível para não ser a lista infinita
            shrinkWrap: true,
            // Quantidades de unidades na horizontal
            crossAxisCount: 4,
            itemCount: homeManager.editing
                ? section.items.length + 1
                : section.items.length,
            itemBuilder: (_, index) {
              if (index < section.items.length)
                return ItemTile(
                  section.items[index],
                );
              else
                return AddTileWidget();
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
