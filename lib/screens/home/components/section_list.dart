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
        children: <Widget>[
          SectionHeader(section),
        ],
      ),
    );
  }
}
