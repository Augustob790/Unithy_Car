import 'package:flutter/material.dart';

class Configuracoes {
  static List<DropdownMenuItem<String>> getCategoria() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    //Categorias
    itensDropCategorias.add(DropdownMenuItem(
      child: Text(
        "Categorias",
        style: TextStyle(color: Colors.amber, fontSize: 25),
      ),
      value: null,
    ));
    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Compra"),
      value: "Compra",
    ));
    return itensDropCategorias;
  }
}
