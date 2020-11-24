import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supermercado_virtual/models/section.dart';

class HomeManager {
  HomeManager() {
    _loadSections();
  }
  List<Section> sections = [];

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    // firestore.collection('home').getDocuments();
    // o snapshot no lugar do docments é para atualizar em tempo real, sem precisar recarregar a tela
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocuments(document));
      }
      print(sections);
    });
  }
}
