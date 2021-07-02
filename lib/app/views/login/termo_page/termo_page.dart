import 'package:flutter/material.dart';

class Termo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Termos de uso do App"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                "Termos de uso do App",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Este é um contrato firmado entre você, de agora em"
                  "diante denominado como usuário,e a Webnow Tecnologia Eireli, "
                  " empresa  cadastrada  no  CNPJ  sob  nº  05.232.644/0001-29  "
                  "com  sede  no  município  deSão  Paulo,  capital  do estado,  "
                  "aAv. Paulista,  1079–7º  andar, e  de  agora  em  diante  "
                  "denominada  simplesmente deWebnow.  Este “Termo de Usode  "
                  "Aplicativo” rege o uso de  todos os  aplicativos "
                  "disponibilizados  gratuitamente  pela Webnow sejampara "
                  "dispositivos móveis (Android, IOS, Windows Mobile), "
                  "servidores, computadores pessoais (desktops) ou serviços"
                  " web.Se você não concordar com estes termos não use este "
                  "aplicativo.Você  reconhece aindaque analisou  e  aceitou as "
                  " condições  de  uso. Leia-asatentamentepois  ouso  deste"
                  " aplicativo significa que você aceitou todos os termos e"
                  " concorda em cumpri-los.Se você, usuário,for menor de idadeou"
                  "  declarado  incapaz  em  quaisquer aspectos,precisará  da "
                  " permissão  deseuspais  ou  responsáveis  que também deverão"
                  "concordar com estes mesmos termose condições.",
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
