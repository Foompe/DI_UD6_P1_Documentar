import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/viewmodels/Pedidos_viewmodel.dart';
import 'package:t4_1_navegacion/views/widgets/Producto_card_item.dart';

class Productospage extends StatefulWidget {
  final PedidosViewmodel viewmodel;

  const Productospage({super.key, required this.viewmodel});

  @override
  State<Productospage> createState() => _ProductospageState();
}

class _ProductospageState extends State<Productospage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF673AB7),
        title: const Text(
          "Productos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            //Campo de texto (mesa - nombre)
            Container(
              width: double.infinity,
              color: const Color(0xFFD1C4E9),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Mesa / Nombre: ${widget.viewmodel.pedido.nombreMesa}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            //Lista de producos
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(horizontal: 12),

                child: ListView.builder(
                  itemCount: widget.viewmodel.listaProductos().length,
                  itemBuilder: (context, index) {
                    final producto = widget.viewmodel.listaProductos()[index];
                    final cantidad =
                        widget.viewmodel.productosSeleccionados[producto] ?? 0;

                    return ProductoCardItem(
                      producto: producto,
                      cantidad: cantidad,
                      onAgregar: () {
                        widget.viewmodel.agregarProducto(producto);
                        setState(() {});
                      },
                      onQuitar: () {
                        widget.viewmodel.quitarProducto(producto);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      //Bottom bar con los botones
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [

              //Boton cancelar
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC62828),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              //Boton Guardar
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, widget.viewmodel.pedido);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
