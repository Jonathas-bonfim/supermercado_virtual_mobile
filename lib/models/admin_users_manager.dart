import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:supermercado_virtual/models/user.dart';
import 'package:supermercado_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final Firestore firestore = Firestore.instance;
// para não ficar buscando os dados do usuário infinitamente
  StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    // Para não ficar consumindo dados na memória, se o usuário for administrador ele vai fica atualizando em tempo real
    // o ponto de interrogação é que se o subscription for nulo não vai cancelar, para evitar o erro
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      // caso o usuário não seja administrador limpar a lista de usuários
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    //  Buscando apenas uma vez os usuários
//  firestore.collection('users').getDocuments().then((snapshot) {
//   users = snapshot.documents.map((d) => User.fromDocument(d)).toList();

    // Buscando em tempo real
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((d) => User.fromDocument(d)).toList();

      // ordenando pelo nome
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    });
    notifyListeners();
  }

  List<String> get names => users.map((e) => e.name).toList();
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
