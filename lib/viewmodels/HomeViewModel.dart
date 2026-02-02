import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/PedidosRepositorioMock.dart';
import 'package:t4_1_navegacion/models/pedido.dart';

class Homeviewmodel extends ChangeNotifier{
  final Pedidosrepositoriomock _repo;
  List<Pedido> pedidos = [];

  Homeviewmodel({Pedidosrepositoriomock? repo}) 
  : _repo = repo ?? Pedidosrepositoriomock() {
    _cargarPedidos();
  }

  void _cargarPedidos() {
    pedidos = _repo.obtenerPedidosPrueba();
    notifyListeners();
  }

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