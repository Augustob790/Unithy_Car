import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc/app/home/home_page.dart';
import 'package:tcc/app/views/relatorios/relatorios_page.dart';
import 'package:tcc/app/views/splash_page/splash_page.dart';
import 'package:tcc/app/views/compra/compra_page/compra_page.dart';
import 'package:tcc/app/views/compra/detalhes_compras_page/detalhes_compras_page.dart';
import 'package:tcc/app/views/compra/minhas_compras/minhas_compras_page.dart';
import 'package:tcc/app/views/compra/nova_compra/nova_compra_page.dart';
import 'package:tcc/app/views/login/cadastro_page/cadastro_page.dart';
import 'package:tcc/app/views/login/reset_password/reset-password.dart';
import 'package:tcc/app/views/login/login_page/login_page.dart';
import 'package:tcc/app/views/login/termo_page/termo_page.dart';
import 'package:tcc/app/views/vendas/detalhes_vendas/detalhes_vendas_page.dart';
import 'package:tcc/app/views/vendas/minhas_vendas/minhas_vendas_page.dart';
import 'package:tcc/app/views/vendas/nova_vendas/nova_vendas_page.dart';
import 'package:tcc/app/views/vendas/vendas_page/vendas_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //Login
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());
      case "/termo":
        return MaterialPageRoute(builder: (_) => Termo());
      case "/reset-password":
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      //Compras
      case "/minhas-compra":
        return MaterialPageRoute(builder: (_) => MinhasCompras());
      case "/compra":
        return MaterialPageRoute(builder: (_) => Compra());
      case "/nova-compra":
        return MaterialPageRoute(builder: (_) => NovaCompra());
      case "/detalhes-compras":
        return MaterialPageRoute(builder: (_) => Detalhes(args));

      //Relatorios
      case "/relatorios":
        return MaterialPageRoute(builder: (_) => RelatoriosPage());

      case "/home":
        return MaterialPageRoute(builder: (_) => HomePage());

      //Vendas
      case "/minhas-vendas":
        return MaterialPageRoute(builder: (_) => MinhasVendas());
      case "/vendas":
        return MaterialPageRoute(builder: (_) => VendasPages());
      case "/nova-venda":
        return MaterialPageRoute(builder: (_) => NovaVendasPage());
      case "/detalhes-vendas":
        return MaterialPageRoute(builder: (_) => DetalhesVenda(args));
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
