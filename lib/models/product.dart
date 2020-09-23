import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    // o firebase retorna uma lista dinamica e eu preciso de uma lista de string
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String name;
  String description;
  List<String> images;
}
