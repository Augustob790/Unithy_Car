import 'package:cloud_firestore/cloud_firestore.dart';

class CompraCarro {
  String _id;
  String _categoria;
  String _titulo;
  String _chassi;
  String _dataFab;
  String _placa;
  String _rua;
  String _cor;
  String _preco;
  String _compra;
  List<String> _fotos;
  CompraCarro();

  CompraCarro.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.categoria = documentSnapshot["categoria"];
    this.titulo = documentSnapshot["modelo"];
    this.rua = documentSnapshot["marca"];
    this.dataFab = documentSnapshot["dataFab"];
    this.placa = documentSnapshot["placa"];
    this.cor = documentSnapshot["cor"];
    this.compra = documentSnapshot["compra"];
    this.preco = documentSnapshot["preco"];
    this.chassi = documentSnapshot["chassi"];

    this.fotos = List<String>.from(documentSnapshot["fotos"]);
  }

  CompraCarro.gerarId() {
    //gera o anuncio antes de grava  as informaçoes
    Firestore db = Firestore.instance;
    CollectionReference compracarro = db.collection("minhas_compracarros");
    this.id = compracarro.document().documentID;

    this.fotos = [];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "categoria": this.categoria,
      "modelo": this.titulo,
      "chassi": this.chassi,
      "marca": this.rua,
      "dataFab": this.dataFab,
      "placa": this.placa,
      "fotos": this.fotos,
      "cor": this.cor,
      "compra": this.compra,
      "preco": this.preco,
    };
    return map;
  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get chassi => _chassi;

  set chassi(String value) {
    _chassi = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }

  String get dataFab => _dataFab;

  set dataFab(String value) {
    _dataFab = value;
  }

  String get placa => _placa;

  set placa(String value) {
    _placa = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get cor => _cor;

  set cor(String value) {
    _cor = value;
  }

  String get compra => _compra;

  set compra(String value) {
    _compra = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
