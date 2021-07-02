import 'package:cloud_firestore/cloud_firestore.dart';

class Venda {
  String _id;
  String _categoria;
  String _titulo;
  String _rua;
  String _dataVenda;
  String _placa;
  String _valorVenda;
  String _cor;
  List<String> _fotos;

  Venda.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.categoria = documentSnapshot["categoria"];
    this.titulo = documentSnapshot["modelo"];
    this.rua = documentSnapshot["marca"];
    this.dataVenda = documentSnapshot["dataVenda"];
    this.placa = documentSnapshot["placa"];
    this.valorVenda = documentSnapshot["valorVenda"];
    this.cor = documentSnapshot["cor"];

    this.fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  Venda.gerarId() {
    //gera o anuncio antes de grava  as informaçoes
    Firestore db = Firestore.instance;
    CollectionReference venda = db.collection("minhas_vendas");
    this.id = venda.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "categoria": this.categoria,
      "modelo": this.titulo,
      "marca": this.rua,
      "dataVenda": this.dataVenda,
      "valorVenda": this.valorVenda,
      "placa": this.placa,
      "fotos": this.fotos,
      "cor": this.cor,
    };
    return map;
  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get valorVenda => _valorVenda;

  set valorVenda(String value) {
    _valorVenda = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get dataVenda => _dataVenda;

  set dataVenda(String value) {
    _dataVenda = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get placa => _placa;

  set placa(String value) {
    _placa = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }

  String get cor => _cor;

  set cor(String value) {
    _cor = value;
  }
}
