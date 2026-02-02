import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/views/DetallesPage.dart';
import 'package:t4_1_navegacion/views/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bar App",
      initialRoute: HomePage.nombreRuta,
      routes: {
        HomePage.nombreRuta: (_) => const HomePage(), 
        DetallesPage.nombreRuta: (context) {
          final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
          return DetallesPage(pedido: pedido);
        }
      },
    );
  }
}
