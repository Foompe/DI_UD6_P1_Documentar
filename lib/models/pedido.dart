import 'package:t4_1_navegacion/models/Producto.dart';

class Pedido {

  //Atributos
  String nombreMesa;
  final Map<Producto, int> productos;

  //Constructor
  Pedido({
    required this.nombreMesa,
    Map<Producto, int>? productos,
  }): productos = productos ?? {};

  //Métodos
  //Añadir/sumar
  void agregarProducto(Producto p) {
    if(productos.containsKey(p)) {
      productos[p] = productos[p]! +1;
    } else {
      productos[p] = 1;
    }
  }

  //restar
  void restarProducto(Producto p) {
    if(!productos.containsKey(p)) return;

    if (productos[p] == 1) {
      productos.remove(p);
    } else {
      productos[p] = productos[p]! -1;
    }
  }

  //Calculo total
  double calcularTotal() {
    double total = 0;

    for(var entry in productos.entries) {
      final producto = entry.key;
      final cantidad = entry.value;

      total += producto.precio * cantidad;
    }
    return total;
  }

}