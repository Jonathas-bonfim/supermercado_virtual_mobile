import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Text(section.name);
  }
}
