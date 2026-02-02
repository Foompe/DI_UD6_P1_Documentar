import 'package:t4_1_navegacion/models/producto.dart';

///Clase que representa un pedido de productos
class Pedido {

  String nombreMesa;
  final Map<Producto, int> productos;

  Pedido({
    required this.nombreMesa,
    Map<Producto, int>? productos,
  }): productos = productos ?? {};

  ///Metodo para agregar un producto
  void agregarProducto(Producto p) {
    if(productos.containsKey(p)) {
      productos[p] = productos[p]! +1;
    } else {
      productos[p] = 1;
    }
  }

  ///Metodo para restar un producto
  void restarProducto(Producto p) {
    if(!productos.containsKey(p)) return;

    if (productos[p] == 1) {
      productos.remove(p);
    } else {
      productos[p] = productos[p]! -1;
    }
  }

  ///Metodo para calcular el total del pedido
  ///@return total del pedido double
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