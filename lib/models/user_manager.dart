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

  FirebaseUser user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> singIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      //obtendo o usuário logado
      this.user = result.user;

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

      this.user = result.user;
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

  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }
}
