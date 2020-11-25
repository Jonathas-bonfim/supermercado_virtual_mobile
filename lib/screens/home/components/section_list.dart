import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/section.dart';
import 'package:supermercado_virtual/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
                // AspectRatio força a imagem a ficar quadrada
                return AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      section.items[index].image,
                      // para a imagem ocupar o máximo de espaço possível
                      fit: BoxFit.cover,
                    ));
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
