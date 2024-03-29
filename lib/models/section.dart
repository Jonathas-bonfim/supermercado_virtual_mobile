import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermercado_virtual/models/section_item.dart';

class Section {
  Section({this.name, this.type, this.items}) {
    items = items ?? [];
  }

  Section.fromDocuments(DocumentSnapshot document) {
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  String name;
  String type;
  List<SectionItem> items;

  Section clone() {
    return Section(
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
