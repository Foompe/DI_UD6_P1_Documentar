import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/viewmodels/HomeViewModel.dart';
import 'package:t4_1_navegacion/views/CreatePage.dart';
import 'package:t4_1_navegacion/views/widgets/pedido_card_widget.dart';

/// Página principal que muestra la lista de pedidos.
/// Permite crear nuevos pedidos y editar los existentes.
/// Utiliza un [Homeviewmodel] para gestionar el estado de los pedidos.

class HomePage extends StatefulWidget {
  static const nombreRuta = "/";
  //Constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Homeviewmodel viewmodel = Homeviewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF673AB7),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white
          ),
          ),
      ),

      body: SafeArea(
        child: Container(
          color: Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            itemCount: viewmodel.pedidos.length,
            itemBuilder: (context, index) {
              final pedido = viewmodel.pedidos[index];
              return PedidoCardWidget(
                pedido: pedido,

                //Configuramos que pasa al pulsar la tarjeta
                onTap: () async {
                  final actualizado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreatePage(
                        pedidoExistente: pedido,
                        homeviewmodel: viewmodel
                        ),
                    ),
                  );
                  if (actualizado != null && actualizado is Pedido) {
                    if(!mounted) return;
                    setState(() {
                      viewmodel.agregarPedido(actualizado);
                    });
                  }
                },
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          child: ElevatedButton(
            onPressed: () async {
              // Navegamos a CreatePage sin pedido (nuevo pedido)
              final nuevoPedido = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreatePage(
                    pedidoExistente:null,
                    homeviewmodel: viewmodel,
                    )
                    ),
              );

              if (nuevoPedido != null && nuevoPedido is Pedido) {
                if(!mounted) return;
                setState(() {
                  viewmodel.agregarPedido(nuevoPedido);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF673AB7),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Nuevo pedido",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
