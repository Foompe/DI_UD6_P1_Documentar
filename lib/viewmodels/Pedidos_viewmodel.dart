import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/Producto.dart';
import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/models/productos_data.dart';
import 'package:t4_1_navegacion/viewmodels/HomeViewModel.dart';

class PedidosViewmodel extends ChangeNotifier {
  Pedido pedido;
  late bool esEdicion;
  late Homeviewmodel homeviewmodel;

  PedidosViewmodel({required this.pedido});

  bool nombreValido() {
    final nombre = pedido.nombreMesa.trim();

    //Si se edita no hace falta confirmar
    if (esEdicion) return true;

    if (nombre.isEmpty) return false;

    //comprobamos si ya existe un pedido con este nombre
    final existe = homeviewmodel.pedidos.any((p) => p.nombreMesa == nombre);

    return !existe;
  }

  void agregarProducto(Producto p) {
    pedido.agregarProducto(p);
    notifyListeners();
  }

  void quitarProducto(Producto p) {
    pedido.restarProducto(p);
    notifyListeners();
  }

  Map<Producto, int> get productosSeleccionados => pedido.productos;

  List<Producto> listaProductos() {
    return productosDisponibles;
  }
}
