import 'package:flutter/material.dart';
import 'package:supermercado_virtual/helpers/validators.dart';
import 'package:provider/provider.dart';
import 'package:supermercado_virtual/models/user.dart';
import 'package:supermercado_virtual/models/user_manager.dart';

class LoginScreen extends StatelessWidget {
  // criando as variáveis para pegar as informações de login e senha
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passControler = TextEditingController();

  // definindo A variável global para autenticar as validações
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //usado para inserir a notificação do snackbar
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/singup');
            },
            textColor: Colors.white,
            child: const Text(
              'Criar Conta',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          //distancia entre as bordas do aplicativo e a tela do celular
          margin: const EdgeInsets.symmetric(horizontal: 16),
          //o form é para efetivar a validação dos campos, ele precisa estar acima dos campos a serem validados
          child: Form(
            key: formKey,
            // É um observador que vai indicar as mudanças
            // UserManager é o objeto que estamos observando
            child: Consumer<UserManager>(
                //os childs são uma forma de eu não rebildar todo o meu código, ex coisas que são constantes
                //útil quando for um widget muito grande.
                builder: (_, userManager, __) {
              return ListView(
                //para o list view usar o mínimo de espaço
                shrinkWrap: true,
                //distancia das bordas e o campo de texto
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: emailControler,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (!emailValid(email)) return 'E-mail inválido';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passControler,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty || pass.length < 6)
                        return 'Senha Inválida';
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: const Text('Esqueci minha senha')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //O Sisedbox é apenas para definir a altura
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              //validando as informações ao pressionar o botão entrar
                              if (formKey.currentState.validate()) {
                                // Ao usar o Consumer<UserManager> temos acesso direto e não precisamos mais usar o
                                // context.read<UserManager>()
                                userManager.singIn(
                                  user: User(
                                    email: emailControler.text,
                                    password: passControler.text,
                                  ),
                                  onFail: (e) {
                                    // print(e);
                                    scafoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                    print('Sucesso');
                                  },
                                );
                              }
                            },
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
