import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:supermercado_virtual/models/item_size.dart';

class Product extends ChangeNotifier {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    // o firebase retorna uma lista dinamica e eu preciso de uma lista de string
    images = List<String>.from(document.data['images'] as List<dynamic>);
    // Aula 37
    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();

    print(sizes);
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  ItemSize _selectSize;

  ItemSize get selectSize => _selectSize;
  set selectSize(ItemSize value) {
    _selectSize = _selectSize;
  }
}
