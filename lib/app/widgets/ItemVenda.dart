import 'package:flutter/material.dart';
import 'package:tcc/app/models/venda.dart';

// ignore: must_be_immutable
class ItemVenda extends StatefulWidget {
  Venda venda;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemVenda({@required this.venda, this.onTapItem, this.onPressedRemover});

  @override
  _ItemVendaState createState() => _ItemVendaState();
}

class _ItemVendaState extends State<ItemVenda> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTapItem,
      child: Card(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              //Imagem
              SizedBox(
                width: 650,
                height: 280,
                child: Image.network(
                  widget.venda.fotos[0],
                  fit: BoxFit.cover,
                ),
              ),

              //Titulo descricao localizacao

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      widget.venda.titulo,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.venda.rua)
                  ],
                ),
              ),

              //botao remover
              if (this.widget.onPressedRemover != null)
                Container(
                  child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.all(10),
                      onPressed: this.widget.onPressedRemover,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
