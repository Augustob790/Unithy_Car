import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/app/models/venda.dart';
import 'package:tcc/app/widgets/ItemVenda.dart';

class MinhasVendas extends StatefulWidget {
  @override
  _MinhasVendasState createState() => _MinhasVendasState();
}

class _MinhasVendasState extends State<MinhasVendas> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuarioLogado;

  _recuperaDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerVendas() async {
    await _recuperaDadosUsuarioLogado();

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("minhas_vendas")
        .document(_idUsuarioLogado)
        .collection("vendas")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _removerVendas(String idVenda) {
    Firestore db = Firestore.instance;
    db
        .collection("minhas_vendas")
        .document(_idUsuarioLogado)
        .collection("vendas")
        .document(idVenda)
        .delete()
        .then((_) {
      db.collection("vendas").document(idVenda).delete();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adicionarListenerVendas();
  }

  @override
  Widget build(BuildContext context) {
    var carregarDados = Center(
      child: Column(
        children: [Text("Carregando vendas"), CircularProgressIndicator()],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Minhas Vendas"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/nova-venda");
          },
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: StreamBuilder(
            stream: _controller.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return carregarDados;
                  break;
                case ConnectionState.active:
                case ConnectionState.done:

                  //Exibe uma mensagem de erro
                  if (snapshot.hasError)
                    return Text("Erro ao recupera os dados");
                  //Recuperando os dados

                  QuerySnapshot querySnapshot = snapshot.data;

                  return ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (_, indice) {
                        List<DocumentSnapshot> vendas =
                            querySnapshot.documents.toList();
                        DocumentSnapshot documentSnapshot = vendas[indice];
                        Venda venda =
                            Venda.fromDocumentSnapshot(documentSnapshot);

                        return ItemVenda(
                          venda: venda,
                          onPressedRemover: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Confirmar"),
                                  content: Text(
                                      "Deseja realmente excluir esta vendas?"),
                                  actions: [
                                    FlatButton(
                                      color: Colors.black,
                                      child: Text(
                                        " Cancelar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.red,
                                      child: Text(
                                        " Remover",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onPressed: () {
                                        _removerVendas(venda.id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      });
              }
              return Container();
            }));
  }
}
