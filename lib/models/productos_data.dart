import 'package:t4_1_navegacion/models/producto.dart';


/// Lista de productos disponibles
/// Cada producto tiene una imagen, un nombre y un precio
/// La imagen es una ruta relativa a la carpeta assets/img
/// El nombre es una cadena de texto
/// El precio es un número decimal
/// Esta lista se utiliza para mostrar los productos en la aplicación
final List<Producto> productosDisponibles = [
  Producto(imagen: "assets/img/cocacola.png", nombre: "Cola Cola", precio: 2.5),
  Producto(imagen: "assets/img/fanta.png", nombre: "Fanta", precio: 2.3),
  Producto(imagen: "assets/img/agua.png", nombre: "Agua", precio: 1.5),
  Producto(imagen: "assets/img/vino.png", nombre: "Copa vino", precio: 2.9),
  Producto(imagen: "assets/img/cerveza.png", nombre: "Cerveza", precio: 2.85),
  Producto(imagen: "assets/img/hamburguesa.png", nombre: "Hamburguesa", precio: 6.5),
  Producto(imagen: "assets/img/pizza.png", nombre: "Pizza", precio: 12.5),
  Producto(imagen: "assets/img/tortilla.png", nombre: "Tortilla", precio: 11.0),
  Producto(imagen: "assets/img/ramen.png", nombre: "Ramen", precio: 7.8),
  Producto(imagen: "assets/img/kebab.png", nombre: "Durum", precio: 8.4),
  Producto(imagen: "assets/img/espaguetis.png", nombre: "Espaguetis", precio: 9.5),
  Producto(imagen: "assets/img/pulpo.png", nombre: "Pulpo", precio: 12.2),
  Producto(imagen: "assets/img/ensalada.png", nombre: "Ensalada", precio: 7.4),
  Producto(imagen: "assets/img/yogurt.png", nombre: "Yogurt", precio:5.5),
  Producto(imagen: "assets/img/flan.png", nombre: "Flan", precio: 4.7),  
];
