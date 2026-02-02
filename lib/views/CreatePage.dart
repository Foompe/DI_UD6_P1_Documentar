import 'package:flutter/material.dart';
import 'package:t4_1_navegacion/models/pedido.dart';
import 'package:t4_1_navegacion/viewmodels/HomeViewModel.dart';
import 'package:t4_1_navegacion/viewmodels/Pedidos_viewmodel.dart';
import 'package:t4_1_navegacion/views/DetallesPage.dart';
import 'package:t4_1_navegacion/views/ProductosPage.dart';


/// Página para crear o editar un pedido
/// Recibe un pedido existente para editar o null para crear uno nuevo
/// Recibe el HomeViewModel para validar nombres
/// Muestra campos para nombre de mesa y botones para añadir productos y ver resumen
/// Botones para cancelar o guardar el pedido en la parte inferior
/// Valida que el nombre no esté vacío ni repetido y que haya productos antes de guardar
class CreatePage extends StatefulWidget {
  final Pedido? pedidoExistente;
  final Homeviewmodel homeviewmodel;

  const CreatePage({
    super.key,
    this.pedidoExistente,
    required this.homeviewmodel,
  });

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late PedidosViewmodel viewmodel;
  late TextEditingController nombreControl;
  bool get esEdicion => widget.pedidoExistente != null;

  @override
  void initState() {
    super.initState();

    //Si recibimos un pedido lo clonamos , si no , creamos uno nuevo
    final pedidoTemp = widget.pedidoExistente != null
        ? Pedido(
            nombreMesa: widget.pedidoExistente!.nombreMesa, //Copiamos nombre
            productos: Map.from(
              widget.pedidoExistente!.productos,
            ), //Copiamos productos
          )
        : Pedido(nombreMesa: "");

    viewmodel = PedidosViewmodel(
      pedido: pedidoTemp,
    ); //Creamos viewmodel para este pedido
    viewmodel.homeviewmodel = widget.homeviewmodel;
    viewmodel.esEdicion = esEdicion;
    nombreControl = TextEditingController(
      text: pedidoTemp.nombreMesa,
    ); //rellenamos el textfield
  }

  @override
  void dispose() {
    nombreControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF673AB7),
        centerTitle: true,
        title: const Text(
          "Pedido",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        elevation: 2,
      ),

      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Mesa / nomrbe: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 8),

              //TextField
              TextField(
                controller: nombreControl,
                enabled: !esEdicion,
                onChanged: (value) {
                  setState(() {
                    viewmodel.pedido.nombreMesa = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  hintText: "Introduce nombre de la mesa",
                  errorText: nombreControl.text.isEmpty
                      ? "Nombre obligatorio"
                      : (viewmodel.nombreValido()
                            ? null
                            : "Nombre ya existente"),
                ),
              ),

              const SizedBox(height: 8),

              //Boton "Añadir"
              ElevatedButton(
                onPressed: () {
                  if (!viewmodel.nombreValido()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Nombre inválido o ya existente"),
                      ),
                    );
                    return;
                  }

                  final pedidoCopia = Pedido(
                    nombreMesa: viewmodel.pedido.nombreMesa,
                    productos: Map.from(viewmodel.pedido.productos),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Productospage(
                        viewmodel: PedidosViewmodel(pedido: pedidoCopia),
                      ),
                    ),
                  ).then((resultado) {
                    if (resultado != null && resultado is Pedido) {
                      setState(() {
                        viewmodel.pedido = resultado;
                      });
                    }
                  });
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
                  "Añadir productos",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 10),

              //Boton resumen
              ElevatedButton(
                onPressed: () {
                  //Validamos nombre y productos
                  if (viewmodel.pedido.nombreMesa.isEmpty ||
                      viewmodel.pedido.productos.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pedido incompleto")),
                    );
                    return;
                  }

                  //Navegamos a la ruta nombrada
                  //TODO: Corregir (no se pasan modelos)
                  Navigator.pushNamed(
                    context,
                    DetallesPage.nombreRuta,
                    arguments: viewmodel.pedido,
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9575CD),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Ver resumen",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),

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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Cancelar"),
                ),
              ),

              //Separador boton
              const SizedBox(width: 12),

              //Boton Guardar
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (!viewmodel.nombreValido()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nombre invalido o repetido"),
                        ),
                      );
                      return;
                    }

                    if (viewmodel.pedido.nombreMesa.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("El pedido debe tener un nombre"),
                        ),
                      );
                      return;
                    }

                    if (viewmodel.productosSeleccionados.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Debes añadir al menos un producto"),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(
                      context,
                      viewmodel.pedido,
                    ); // devuelve pedido a HomePage
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Guardar pedido"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
