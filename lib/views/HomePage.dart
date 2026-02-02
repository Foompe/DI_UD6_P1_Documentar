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
          child: viewmodel.pedidos.isEmpty
              // Empty State: cuando no hay pedidos
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No hay pedidos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pulsa 'Nuevo pedido' para comenzar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: viewmodel.pedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = viewmodel.pedidos[index];
                    return PedidoCardWidget(
                      pedido: pedido,
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
                          
                          // SnackBar de confirmación al actualizar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pedido "${actualizado.nombreMesa}" actualizado'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
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
          child: Tooltip(
            message: 'Crear un nuevo pedido para una mesa',
            child: ElevatedButton(
              onPressed: () async {
                final nuevoPedido = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreatePage(
                      pedidoExistente: null,
                      homeviewmodel: viewmodel,
                    )
                  ),
                );
                
                if (nuevoPedido != null && nuevoPedido is Pedido) {
                  if(!mounted) return;
                  setState(() {
                    viewmodel.agregarPedido(nuevoPedido);
                  });
                  
                  // SnackBar de confirmación al crear
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pedido "${nuevoPedido.nombreMesa}" creado correctamente'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
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
      ),
    );
  }
}