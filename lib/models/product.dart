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
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }
}