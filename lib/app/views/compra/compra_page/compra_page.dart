import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/app/models/compra.dart';
import 'package:tcc/app/util/Configuracoes.dart';
import 'package:tcc/app/widgets/ItemCompra.dart';
import '../../../../main.dart';

class Compra extends StatefulWidget {
  @override
  _CompraState createState() => _CompraState();
}

class _CompraState extends State<Compra> {
  List<String> itensMenu = [];
  String _itemSelecionaCategoria;
  List<DropdownMenuItem<String>> _listaItensDropCategorias;
  final _controler = StreamController<QuerySnapshot>.broadcast();

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Minhas denuncias", "Deslogar"];
    }
  }

  _carregarItensDropdown() {
    _listaItensDropCategorias = Configuracoes.getCategoria();
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerCompraCarros() async {
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db.collection("compracarros").snapshots();

    stream.listen((dados) {
      _controler.add(dados);
    });
  }

  Future<Stream<QuerySnapshot>> _filtrarCompraCarros() async {
    Firestore db = Firestore.instance;
    Query query = db.collection("compracarros");
    if (_itemSelecionaCategoria != null) {
      query = query.where("categoria", isEqualTo: _itemSelecionaCategoria);
    }
    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controler.add(dados);
    });
  }

  String _emailUsuario = "";
  String _nome = "";
  String _idUsuarioLogado = "";

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuario").document(_idUsuarioLogado).get();
    Map<String, dynamic> dados = snapshot.data;

    setState(() {
      _emailUsuario = usuarioLogado.email;
      _nome = dados["nome"];
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _adicionarListenerCompraCarros();

    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: [
          Text("Carregando compra Carros"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Compras"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              //color: Color(0xff0df587),
              icon: Icon(Icons.exit_to_app),
              /*child: Text(
                "Sair",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),*/
              onPressed: () {
                _deslogarUsuario();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/nova-compra");
        },
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        //Color(0xffB312C3),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_nome),
              accountEmail: Text(_emailUsuario),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("imagens/profile.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text(
                "Minhas Compras",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/minhas-compra");
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text(
                "Minhas Vendas",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/minhas-vendas");
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonHideUnderline(
                    child: Center(
                  child: DropdownButton(
                      iconEnabledColor: temaPadrao.primaryColor,
                      value: _itemSelecionaCategoria,
                      items: _listaItensDropCategorias,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      onChanged: (categoria) {
                        setState(() {
                          _itemSelecionaCategoria = categoria;
                          _filtrarCompraCarros();
                        });
                      }),
                )),
              ],
            ),
            StreamBuilder(
                stream: _controler.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return carregandoDados;
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      QuerySnapshot querySnapshot = snapshot.data;

                      if (querySnapshot.documents.length == 0) {
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Nenhuma Compra",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                            itemCount: querySnapshot.documents.length,
                            itemBuilder: (_, indice) {
                              List<DocumentSnapshot> compracarros =
                                  querySnapshot.documents.toList();
                              DocumentSnapshot documentSnapshot =
                                  compracarros[indice];
                              CompraCarro compracarro =
                                  CompraCarro.fromDocumentSnapshot(
                                      documentSnapshot);
                              return ItemCompra(
                                  compraCarro: compracarro,
                                  onTapItem: () {
                                    Navigator.pushNamed(
                                        context, "/detalhes-compras",
                                        arguments: compracarro);
                                  });
                            }),
                      );
                  }

                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
