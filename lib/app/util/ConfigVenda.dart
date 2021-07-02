import 'package:flutter/material.dart';

class ConfigVendas {
  static List<DropdownMenuItem<String>> getCategoria() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(DropdownMenuItem(
      child: Text(
        "Categorias",
        style: TextStyle(color: Colors.amber, fontSize: 25),
      ),
      value: null,
    ));
    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Venda"),
      value: "Venda",
    ));
    return itensDropCategorias;
  }
}
