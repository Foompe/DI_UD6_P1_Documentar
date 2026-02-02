import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/models/productos_data.dart';

class Pedidosrepositoriomock {
  List<Pedido> obtenerPedidosPrueba() {
    return [
      Pedido(
        nombreMesa: "Mesa 1",
        productos: {
          productosDisponibles[0]: 2, 
          productosDisponibles[3]: 1
        },
      ),
      Pedido(
        nombreMesa: "Mesa 2",
        productos: {
          productosDisponibles[1]: 1,
          productosDisponibles[4]: 2,
          productosDisponibles[6]: 1,
        },
      ),
      Pedido(
        nombreMesa: "Mesa 3", 
        productos: {
          productosDisponibles[2]: 3
        }
      ),
    ];
  }
}
