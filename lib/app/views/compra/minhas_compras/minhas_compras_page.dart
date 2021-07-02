import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/app/models/compra.dart';
import 'package:tcc/app/widgets/ItemCompra.dart';

class MinhasCompras extends StatefulWidget {
  @override
  _MinhasComprasState createState() => _MinhasComprasState();
}

class _MinhasComprasState extends State<MinhasCompras> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuarioLogado;

  _recuperaDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerCompra() async {
    await _recuperaDadosUsuarioLogado();

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("minhas_compracarros")
        .document(_idUsuarioLogado)
        .collection("compracarros")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _removerCompraCarros(String idCompracarro) {
    Firestore db = Firestore.instance;
    db
        .collection("minhas_compracarros")
        .document(_idUsuarioLogado)
        .collection("compracarros")
        .document(idCompracarro)
        .delete()
        .then((_) {
      db.collection("compracarros").document(idCompracarro).delete();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adicionarListenerCompra();
  }

  @override
  Widget build(BuildContext context) {
    var carregarDados = Center(
      child: Column(
        children: [Text("Carregando Denúncias"), CircularProgressIndicator()],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Minhas Compras"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/nova-compra");
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
                        List<DocumentSnapshot> compracarro =
                            querySnapshot.documents.toList();
                        DocumentSnapshot documentSnapshot = compracarro[indice];
                        CompraCarro compraCarro =
                            CompraCarro.fromDocumentSnapshot(documentSnapshot);
                        return ItemCompra(
                          compraCarro: compraCarro,
                          onPressedRemover: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Confirmar"),
                                  content: Text(
                                      "Deseja realmente excluir esta denúncia?"),
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
                                        _removerCompraCarros(compraCarro.id);
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
