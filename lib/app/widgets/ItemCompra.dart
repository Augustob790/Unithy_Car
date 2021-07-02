import 'package:flutter/material.dart';
import 'package:tcc/app/models/compra.dart';
import 'package:tcc/app/models/venda.dart';

class ItemCompra extends StatelessWidget {
  CompraCarro compraCarro;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemCompra(
      {@required this.compraCarro,
      this.onTapItem,
      this.onPressedRemover,
      Venda venda});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
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
                  compraCarro.fotos[0],
                  fit: BoxFit.cover,
                ),
              ),

              //Titulo descricao localizacao

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      compraCarro.titulo,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(compraCarro.rua)
                  ],
                ),
              ),

              //botao remover
              if (this.onPressedRemover != null)
                Container(
                  child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.all(10),
                      onPressed: this.onPressedRemover,
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
