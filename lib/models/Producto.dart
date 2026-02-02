/// Modelo que representa un producto del catálogo de productos.
/// 
/// Esta clase es inmutable y contiene la información básica
/// de cada producto disponible para pedir.
/// 
/// Ejemplo de uso:
/// ```dart
/// final cerveza = Producto(
///   imagen: "assets/img/cerveza.png",
///   nombre: "Cerveza",
///   precio: 2.85
/// );
/// ```
class Producto {
  /// Ruta de la imagen del producto en la carpeta assets
  final String imagen;

  /// Nombre del producto
  final String nombre;

  /// Precio del producto en euros
  final double precio;

  Producto({
    required this.imagen,
    required this.nombre,
    required this.precio
  });
}