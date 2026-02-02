import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/pedido.dart';

/// Widget que representa una tarjeta de pedido en la lista de pedidos.
/// Recibe un objeto [Pedido] y una función [onTap] que se ejecuta al pulsar la tarjeta.
/// 
/// Muestra icono, nombre de la mesa, cantidad de productos y precio total del pedido.
/// 
/// Parametros:
/// - [pedido]: Objeto de tipo [Pedido] que contiene la información del pedido.
/// - [onTap]: Función que se ejecuta al pulsar la tarjeta.
class PedidoCardWidget extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onTap;

  const PedidoCardWidget({
    super.key,
    required this.pedido,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              //Icono
              const Icon(Icons.person, size: 36, color: Color(0xFF673AB7)),

              //Separador
              const SizedBox(width: 16),

              //Nombre
              Expanded(
                flex: 4,
                child: Text(
                  pedido.nombreMesa,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                  ),
                ),
              ),

              //Candidad productos
              Expanded(
                flex: 3,
                child: Text(
                  "${pedido.productos.length} productos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //Precio total
              Expanded(
                flex: 3,
                child: Text(
                  "${pedido.calcularTotal().toStringAsFixed(2)}€",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF673AB7),
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
