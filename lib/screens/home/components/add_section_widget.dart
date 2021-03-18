import 'package:flutter/material.dart';
import 'package:supermercado_virtual/models/home_manager.dart';
import 'package:supermercado_virtual/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget(this.homeManager);
  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    // o home manager é para informar ao mesmo que está sendo adicionado outra sessão
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Grade'),
          ),
        )
      ],
    );
  }
}
