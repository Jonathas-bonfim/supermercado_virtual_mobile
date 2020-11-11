import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({this.iconData, this.color});

  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      // inkwell só para dar o efeito no botão
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            iconData,
            color: color,
          ),
        ),
      ),
    );
  }
}
