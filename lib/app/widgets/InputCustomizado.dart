import 'package:brasil_fields/brasil_fields.dart';
import 'package:brasil_fields/formatter/cep_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomizado extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  //Rever erro no codogo 1
  //final int maxLines;
  final Function(String) validator;
  final Function(String) onSaved;
  final inputFormatters;

  InputCustomizado(
      {@required this.controller,
      @required this.hint,
      this.obscure = false,
      this.autofocus = false,
      this.type = TextInputType.text,
      //Rever erro no codogo 1
      //this.maxLines,
      this.inputFormatters,
      this.validator,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      inputFormatters: this.inputFormatters,
      obscureText: this.obscure,
      autofocus: this.autofocus,
      keyboardType: this.type,
      validator: this.validator,
      onSaved: this.onSaved,
      style: TextStyle(fontSize: 20),
      //Rever erro no codogo 1
      // maxLines: this.maxLines,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: this.hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
