import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/producto.dart';

/// Widget que representa una tarjeta de producto con opciones para agregar o quitar unidades.
/// 
/// Muestra una card con la imagen, nombre, precio y controles para ajustar la cantidad del producto.
/// 
/// Parametros:
/// [producto]: El producto a mostrar.
/// [cantidad]: La cantidad actual del producto.
/// [onAgregar]: Callback que se ejecuta al agregar una unidad.
/// [onQuitar]: Callback que se ejecuta al quitar una unidad.
/// 
class ProductoCardItem extends StatelessWidget {
  final Producto producto;
  final int cantidad;
  final VoidCallback onAgregar;
  final VoidCallback onQuitar;

  const ProductoCardItem({
    super.key,
    required this.producto,
    required this.cantidad,
    required this.onAgregar,
    required this.onQuitar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 75,
        child: Row(
          children: [
            
            //Imagen
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300
                ),
                image: DecorationImage(
                  image: AssetImage(producto.imagen),
                  fit: BoxFit.contain
                )
              ),
            ),

            //Separador
            const SizedBox(width: 16),

            //Nombre y precio
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238)
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${producto.precio}€",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              )
            ),

            //Cantidad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFD1C4E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300)
              ),


              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  //restar uds (si hay)
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: cantidad > 0 ? onQuitar : null, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cantidad > 0 ? Color(0xFFC62828) : Colors.grey,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        elevation: cantidad > 0 ? 3 : 0, //Sale sombra si esta "activado"
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      child: const Icon(Icons.remove, size: 24, color: Colors.white)
                      ),
                  ),

                  const SizedBox(width: 14),

                  //Cantidad
                  Text(
                    "$cantidad",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238)
                    ),
                  ),

                  const SizedBox(width: 16),

                  //añadir uds
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onAgregar, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF673AB7),
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      child: const Icon(Icons.add, size: 24, color: Colors.white)
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
