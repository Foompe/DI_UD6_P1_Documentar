import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/viewmodels/Pedidos_viewmodel.dart';
import 'package:t4_1_navegacion/views/widgets/producto_card_item.dart';

/// Página de productos donde se muestran los productos disponibles en una lista para agregar al pedido.
/// Recibe un [PedidosViewmodel] para gestionar el estado del pedido.
/// Permite agregar o quitar productos y confirmar o cancelar el pedido.
class Productospage extends StatefulWidget {
  final PedidosViewmodel viewmodel;

  const Productospage({super.key, required this.viewmodel});

  @override
  State<Productospage> createState() => _ProductospageState();
}

class _ProductospageState extends State<Productospage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF673AB7),
        title: const Text(
          "Productos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Campo de texto (mesa - nombre)
            Container(
              width: double.infinity,
              color: const Color(0xFFD1C4E9),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Mesa / Nombre: ${widget.viewmodel.pedido.nombreMesa}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Indicador de productos seleccionados
            if (widget.viewmodel.productosSeleccionados.isNotEmpty)
              Container(
                width: double.infinity,
                color: Color(0xFFE8F5E9),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${widget.viewmodel.productosSeleccionados.length} productos en el pedido",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Lista de productos
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(horizontal: 12),

                child: ListView.builder(
                  itemCount: widget.viewmodel.listaProductos().length,
                  itemBuilder: (context, index) {
                    final producto = widget.viewmodel.listaProductos()[index];
                    final cantidad =
                        widget.viewmodel.productosSeleccionados[producto] ?? 0;

                    return ProductoCardItem(
                      producto: producto,
                      cantidad: cantidad,
                      onAgregar: () {
                        widget.viewmodel.agregarProducto(producto);
                        setState(() {});
                        
                        // SnackBar al añadir producto
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${producto.nombre} añadido'),
                            duration: Duration(milliseconds: 800),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      onQuitar: () {
                        widget.viewmodel.quitarProducto(producto);
                        setState(() {});
                        
                        // SnackBar al quitar producto
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${producto.nombre} eliminado'),
                            duration: Duration(milliseconds: 800),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom bar con los botones
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Botón cancelar con Tooltip
              Expanded(
                child: Tooltip(
                  message: 'Cancelar y volver sin guardar cambios',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: const Text(
                      "Cancelar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC62828),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Botón Confirmar con Tooltip
              Expanded(
                child: Tooltip(
                  message: 'Confirmar productos seleccionados',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (widget.viewmodel.productosSeleccionados.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No has añadido ningún producto"),
                            backgroundColor: Colors.orange,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      
                      Navigator.pop(context, widget.viewmodel.pedido);
                    },
                    icon: Icon(Icons.check),
                    label: const Text(
                      "Confirmar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}