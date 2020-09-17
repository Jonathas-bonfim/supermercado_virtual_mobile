import 'package:flutter/material.dart';
import 'package:supermercado_virtual/helpers/validators.dart';
import 'package:supermercado_virtual/models/user.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/user_manager.dart';

class SingUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name.isEmpty)
                      return "Campo Obrigatório";
                    //trim apaga os espaços no início e no final, split quebra o texto fazendo uma lista onde são gerados a partir do caractere definido no split (espaço no caso)
                    else if (name.trim().split(' ').length <= 1)
                      return "Preencha seu nome completo";
                  },
                  onSaved: (name) => user.name = name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (email.isEmpty)
                      return 'Campo Obrigatório';
                    else if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return "Campo Obrigatório";
                    else if (pass.length < 6) return "Senha muito Curta";
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Repita a senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty)
                      return "Campo Obrigatório";
                    else if (pass.length < 6) return "Senha muito Curta";
                  },
                  onSaved: (pass) => user.confirmPassword = pass,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        if(user.password != user.confirmPassword){
                          scafoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: const Text('Senhas não coincidem!'),
                              backgroundColor: Colors.red,
                            )
                          );
                          return;
                        }
                        context.read<UserManager>().singUp(
                          user: user,
                          onSuccess: (){
                            debugPrint('Sucesso');
                            // TODO POP
                          },
                          onFail: (e){
                          scafoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Falha ao cadastrar: $e'),
                              backgroundColor: Colors.red,
                            )
                          );
                          }
                        );
                      }
                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
