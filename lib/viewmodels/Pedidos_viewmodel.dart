import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/producto.dart';
import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/models/productos_data.dart';
import 'package:t4_1_navegacion/viewmodels/HomeViewModel.dart';

/// ViewModel para la pantalla de Pedidos
/// Contiene la lógica de negocio para gestionar un pedido
/// y notifica a la vista cuando hay cambios.
/// 
/// Proporciona métodos para agregar y quitar productos del pedido,
/// así como para validar el nombre de la mesa.
class PedidosViewmodel extends ChangeNotifier {
  Pedido pedido;
  late bool esEdicion;
  late Homeviewmodel homeviewmodel;

  PedidosViewmodel({required this.pedido});

  ///Metodo que comprueba si el nombre de la mesa es valido
  bool nombreValido() {
    final nombre = pedido.nombreMesa.trim();
    if (esEdicion) return true;
    if (nombre.isEmpty) return false;
    final existe = homeviewmodel.pedidos.any((p) => p.nombreMesa == nombre);
    return !existe;
  }

  /// Agrega un producto al pedido y notifica.
  void agregarProducto(Producto p) {
    pedido.agregarProducto(p);
    notifyListeners();
  }

  /// Quita un producto del pedido y notifica.
  void quitarProducto(Producto p) {
    pedido.restarProducto(p);
    notifyListeners();
  }

  Map<Producto, int> get productosSeleccionados => pedido.productos;

  /// Obtiene la lista de productos disponibles.
  List<Producto> listaProductos() {
    return productosDisponibles;
  }
}
