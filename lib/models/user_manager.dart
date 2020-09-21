import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:supermercado_virtual/helpers/firebase_errors.dart';
import 'package:supermercado_virtual/models/user.dart';

//o extends ChanderNotifier é mudar o estado dos widgets  de acordo com o estado do loading
//lembrando que é necessário alterar o provider para ChangeNotifierProvider no main
class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  // Com o firebase user só temos o Email e ID
  // FirebaseUser user;
  // Com o usuário temos tudoooooo
  User user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> singIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _loadCurrentUser(firebaseUser: result.user);

      // print(result.user.uid);
      onSuccess();
    } on PlatformException catch (e) {
      // print(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  //levando os dados para o firebase
  Future<void> singUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      //colocando o usuário no abjeto geral da página
      this.user = user;
      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // carregando os dados do usuário que está logado e passando para o objeto user
  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    // Quando criar o usuário entrar com ele e não ficar com o usuário atual, caso nenhum
    // usuário seja criado, ficar com o usuário atual no firebase (Aula 27, 5 minutos)
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      // user = currentUser;
      // print(user.uid);

      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      notifyListeners();
    }
  }
}
