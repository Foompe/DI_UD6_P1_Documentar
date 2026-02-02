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

    final pedidoTemp = widget.pedidoExistente != null
        ? Pedido(
            nombreMesa: widget.pedidoExistente!.nombreMesa,
            productos: Map.from(widget.pedidoExistente!.productos),
          )
        : Pedido(nombreMesa: "");

    viewmodel = PedidosViewmodel(pedido: pedidoTemp);
    viewmodel.homeviewmodel = widget.homeviewmodel;
    viewmodel.esEdicion = esEdicion;
    nombreControl = TextEditingController(text: pedidoTemp.nombreMesa);
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
        title: Text(
          esEdicion ? "Editar Pedido" : "Nuevo Pedido",
          style: const TextStyle(
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
                "Mesa / nombre: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 8),

              // TextField con validaciones mejoradas
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
                  fillColor: esEdicion ? Colors.grey[200] : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  hintText: "Ej: Mesa 1, Mesa VIP, Terraza 3",
                  helperText: esEdicion 
                      ? "El nombre no se puede modificar al editar" 
                      : "Introduce un nombre único para identificar la mesa",
                  helperStyle: TextStyle(fontSize: 12),
                  prefixIcon: Icon(
                    Icons.table_bar,
                    color: Color(0xFF673AB7),
                  ),
                  errorText: nombreControl.text.isEmpty
                      ? "El nombre es obligatorio"
                      : (!viewmodel.nombreValido()
                            ? "Ya existe un pedido con este nombre"
                            : null),
                ),
              ),

              const SizedBox(height: 8),

              // Información sobre productos añadidos
              if (viewmodel.productosSeleccionados.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF4CAF50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                      SizedBox(width: 8),
                      Text(
                        "${viewmodel.productosSeleccionados.length} producto(s) añadido(s)",
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // Botón "Añadir productos" con Tooltip
              Tooltip(
                message: 'Selecciona productos del catálogo para añadir al pedido',
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (!viewmodel.nombreValido() || nombreControl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Primero debes introducir un nombre válido para la mesa"),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
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
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Productos añadidos correctamente'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.add_shopping_cart),
                  label: const Text(
                    "Añadir productos",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Botón resumen con Tooltip
              Tooltip(
                message: 'Ver el resumen completo del pedido con el total',
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Validamos nombre y productos
                    if (viewmodel.pedido.nombreMesa.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Debes introducir un nombre para la mesa"),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    
                    if (viewmodel.pedido.productos.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Debes añadir al menos un producto"),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    Navigator.pushNamed(
                      context,
                      DetallesPage.nombreRuta,
                      arguments: viewmodel.pedido,
                    );
                  },
                  icon: Icon(Icons.receipt_long),
                  label: const Text(
                    "Ver resumen",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9575CD),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
              // Botón cancelar con Tooltip
              Expanded(
                child: Tooltip(
                  message: 'Descartar cambios y volver atrás',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: const Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC62828),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Botón Guardar con Tooltip
              Expanded(
                child: Tooltip(
                  message: 'Guardar el pedido y volver a la lista',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Validación completa antes de guardar
                      if (!viewmodel.nombreValido()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("El nombre es inválido o ya existe"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      if (viewmodel.pedido.nombreMesa.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("El pedido debe tener un nombre"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      if (viewmodel.productosSeleccionados.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Debes añadir al menos un producto"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      Navigator.pop(context, viewmodel.pedido);
                    },
                    icon: Icon(Icons.save),
                    label: const Text("Guardar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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