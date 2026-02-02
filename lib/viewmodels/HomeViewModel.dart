import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/PedidosRepositorioMock.dart';
import 'package:t4_1_navegacion/models/pedido.dart';

/// ViewModel para la pantalla principal que gestiona la lista de pedidos
/// y la interacción con el repositorio de pedidos.
/// Extiende ChangeNotifier para notificar a los listeners sobre cambios en los datos.
/// 
/// Proporciona métodos para cargar, agregar y actualizar pedidos.
/// Utiliza un repositorio mock para simular la obtención de datos.
class Homeviewmodel extends ChangeNotifier{
  final Pedidosrepositoriomock _repo;
  List<Pedido> pedidos = [];

  Homeviewmodel({Pedidosrepositoriomock? repo}) 
  : _repo = repo ?? Pedidosrepositoriomock() {
    _cargarPedidos();
  }

  /// Carga los pedidos desde el repositorio y notifica a los listeners.
  void _cargarPedidos() {
    pedidos = _repo.obtenerPedidosPrueba();
    notifyListeners();
  }

  /// Agrega un nuevo pedido o actualiza uno existente en la lista de pedidos.
  /// Si el pedido ya existe (basado en el nombre de la mesa), se actualiza.
  /// Si no, se agrega a la lista.
  /// @param pedido El pedido a agregar o actualizar.
  void agregarPedido(Pedido pedido) {
    final index = pedidos.indexWhere((p) => p.nombreMesa == pedido.nombreMesa);
    
    if(index >= 0) {
      pedidos[index] = pedido;
    } else {
      pedidos.add(pedido);
    }
    notifyListeners();
  }
}