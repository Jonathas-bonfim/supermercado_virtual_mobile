import 'dart:html';
import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager {
  ProductManager() {
    _loadAllProduct();
  }

  final Firestore firestore = Firestore.instance;
  void _loadAllProduct() {}
}
