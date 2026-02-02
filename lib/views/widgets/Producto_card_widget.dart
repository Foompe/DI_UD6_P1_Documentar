import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/producto.dart';

/// Widget que representa una tarjeta de producto mostrando su imagen, nombre y cantidad.
/// 
/// Muestra una card con la imagen del producto, su nombre y la cantidad disponible.
/// 
/// Parametros:
/// [producto]: El producto a mostrar.
/// [cantidad]: La cantidad actual del producto.
///   
class ProductoCardWidget extends StatelessWidget {
  final Producto producto;
  final int cantidad;

  const ProductoCardWidget({
    super.key,
    required this.producto,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF5F5F5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        height: 60,

        child: Row(
          children: [
            //Imagen
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  image: DecorationImage(
                    image: AssetImage(producto.imagen),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            //Espaciado
            const SizedBox(width: 12),

            //Nombre
            Expanded(
              flex: 7,
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  producto.nombre,
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E3E3E)
                    ),
                ),
              ),
            ),

            //Cantidad
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text(
                  "$cantidad Ud",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5E35B1)
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
