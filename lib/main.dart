import 'package:flutter/material.dart';
import 'package:isolate_app_jesus_ku_marco_velasco_joana_chan_maria_chan/home_page.dart';

// Función principal que actúa como punto de entrada de la aplicación.
void main() {
  // Ejecuta la aplicación con el widget raíz `MyApp`.
  runApp(const MyApp());
}

// Clase que define el widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  // Constructor constante para `MyApp`.
  const MyApp({super.key});

  // Este widget representa el punto de inicio de la interfaz gráfica de la aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación (visible en algunas plataformas como navegadores web).
      title: 'Flutter Demo',
      // Tema visual de la aplicación.
      theme: ThemeData(
        // Define un esquema de colores basado en un color semilla (deepPurple).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Activa el uso del diseño Material 3.
        useMaterial3: true,
      ),
      // Página inicial que se muestra al iniciar la aplicación.
      home: const HomePage(),
    );
  }
}

