import 'dart:io';

import 'package:brasil_fields/formatter/data_input_formatter.dart';
import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/app/models/venda.dart';
import 'package:tcc/app/util/ConfigVenda.dart';
import 'package:tcc/app/util/Configuracoes.dart';
import 'package:tcc/app/widgets/InputCustomizado.dart';
import 'package:validadores/Validador.dart';

class NovaVendasPage extends StatefulWidget {
  @override
  _NovaVendasPageState createState() => _NovaVendasPageState();
}

class _NovaVendasPageState extends State<NovaVendasPage> {
  List<File> _listaImagens = List();

  List<DropdownMenuItem<String>> _listaItensDropCategorias = List();
  final _formkey = GlobalKey<FormState>();
  Venda _venda;
  BuildContext _dialogContext;

  String _itemSelecionadoCategoria;

  _selecionarImagemCamera() async {
    File imagemSelecionada = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
        maxHeight: 780,
        maxWidth: 940);

    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  _abrirDailog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contexte) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 25,
                ),
                Text("Salvando denúncia...")
              ],
            ),
          );
        });
  }

  _salvaVendas() async {
    _abrirDailog(_dialogContext);
    //Upload Imagns no Storagew
    await _uploadImagens();

    //Salvar as denuncia no banco de dados Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    Firestore db = Firestore.instance;
    db
        .collection("minhas_vendas")
        .document(idUsuarioLogado)
        .collection("vendas")
        .document(_venda.id)
        .setData(_venda.toMap())
        .then((_) {
      //Salva denuncia publica
      db
          .collection("vendas")
          .document(_venda.id)
          .setData(_venda.toMap())
          .then((value) {
        Navigator.pop(_dialogContext);

        Navigator.pushReplacementNamed(context, "/minhas-vendas");
      });
    });
  }

  //Metodo que pega a lista de imagens e  faz o
  Future _uploadImagens() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();

    for (var imagem in _listaImagens) {
      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference arquivo =
          pastaRaiz.child("minhas_vendas").child("idVendas").child(nomeImagem);
      StorageUploadTask uploadTask = arquivo.putFile(imagem);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      _venda.fotos.add(url);
    }
  }

  _adicionarLocal() {
    Navigator.pushNamed(context, "/mapa");
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _venda = Venda.gerarId();
  }

  _carregarItensDropdown() {
    _listaItensDropCategorias = ConfigVendas.getCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Venda"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField<List>(
                      initialValue: _listaImagens,
                      validator: (imagens) {
                        if (imagens.length == 0) {
                          return "Necessario selecionar uma imagens";
                        }
                        return null;
                      },
                      builder: (State) {
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _listaImagens.length + 1,
                                  itemBuilder: (context, indice) {
                                    if (indice == _listaImagens.length) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(),
                                        child: GestureDetector(
                                          onTap: () {
                                            _selecionarImagemCamera();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[400],
                                            radius: 50,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo,
                                                  size: 40,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  "Adicionar",
                                                  style: TextStyle(
                                                      color: Colors.grey[100]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (_listaImagens.length > 0) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.file(
                                                              _listaImagens[
                                                                  indice]),
                                                          FlatButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _listaImagens
                                                                    .removeAt(
                                                                        indice);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                            child:
                                                                Text("Excluir"),
                                                            textColor:
                                                                Colors.red,
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: FileImage(
                                                _listaImagens[indice]),
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.4),
                                              alignment: Alignment.center,
                                              child: Icon(Icons.delete,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                            if (State.hasError)
                              Container(
                                child: Text(
                                  "[${State.errorText}]",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              )
                          ],
                        );
                      }),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _itemSelecionadoCategoria,
                            hint: Text("Categorias"),
                            onSaved: (categoria) {
                              _venda.categoria = categoria;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            items: _listaItensDropCategorias,
                            validator: (valor) {
                              return Validador()
                                  .add(Validar.OBRIGATORIO,
                                      msg: "Campo obrigatório")
                                  .valido(valor);
                            },
                            onChanged: (valor) {
                              setState(() {
                                _itemSelecionadoCategoria = valor;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: InputCustomizado(
                      controller: null,
                      hint: "Modelo",
                      onSaved: (titulo) {
                        _venda.titulo = titulo;
                      },
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      controller: null,
                      hint: "Marca",
                      //metodo para salvar os dados
                      onSaved: (rua) {
                        _venda.rua = rua;
                      },
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      type: TextInputType.number,
                      controller: null,
                      hint: "Data venda",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      //metodo para salvar os dados
                      onSaved: (dataVenda) {
                        _venda.dataVenda = dataVenda;
                      },
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      type: TextInputType.number,
                      controller: null,
                      hint: "Valor Venda",
                      //metodo para salvar os dados
                      onSaved: (valorVenda) {
                        _venda.valorVenda = valorVenda;
                      },
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: InputCustomizado(
                            controller: null,
                            hint: "Placa",
                            //metodo para salvar os dados
                            onSaved: (placa) {
                              _venda.placa = placa;
                            },
                            validator: (valor) {
                              return Validador()
                                  .add(Validar.OBRIGATORIO,
                                      msg: "Campo obrigatório")
                                  .valido(valor);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      controller: null,
                      hint: "Cor",
                      //metodo para salvar os dados
                      onSaved: (cor) {
                        _venda.cor = cor;
                      },
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Cadastrar Venda",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        //Salvar Campos
                        _formkey.currentState.save();
                        //Configura dialog context
                        _dialogContext = context;
                        //Salvar denuncia
                        _salvaVendas();
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
