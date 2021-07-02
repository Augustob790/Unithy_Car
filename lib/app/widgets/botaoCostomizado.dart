import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado(
      {@required this.texto, this.corTexto = Colors.black, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        this.texto,
        style: TextStyle(color: this.corTexto, fontSize: 20),
      ),
      color: Color(0xffB312C3),
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      onPressed: this.onPressed,
    );
  }
}
