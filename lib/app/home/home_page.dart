import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tcc/app/views/compra/compra_page/compra_page.dart';
import 'package:tcc/app/views/relatorios/relatorios_page.dart';
import 'package:tcc/app/views/vendas/vendas_page/vendas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Compra(),
      VendasPages(),
      RelatoriosPage(),
    ];

    return Scaffold(
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
            ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text(
                " Vendas ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/vendas");
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text(
                "Relatórios",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/relatorios");
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.amber,
          items: [
            BottomNavigationBarItem(
                title: Text("Compra"), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text("Venda"), icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(
                title: Text("Relatorios"), icon: Icon(Icons.subscriptions)),
          ]),
    );
  }
}
