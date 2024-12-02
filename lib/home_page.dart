import "dart:isolate";
import "package:flutter/material.dart";

// Clase que define la página principal de la aplicación.
class HomePage extends StatelessWidget {
  // Constructor constante para `HomePage`.
  const HomePage({super.key});

  // Método que construye la interfaz gráfica de la página.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define el color de fondo de la página.
      backgroundColor: Colors.white,
      // Utiliza `SafeArea` para asegurar que los elementos no se superpongan con áreas restringidas (como la barra de estado).
      body: SafeArea(
        // Centra el contenido en la pantalla.
        child: Center(
          child: Column(
            children: [
              // Muestra una imagen desde los recursos locales.
              Image.asset('assets/gifs/bouncing-ball.gif'),
              // Botón para ejecutar una tarea que bloquea la interfaz de usuario.
              ElevatedButton(
                onPressed: () async {
                  // Ejecuta la tarea compleja y espera su resultado.
                  var total = await complexTask1();
                  debugPrint('Result 1: $total'); // Imprime el resultado en la consola.
                },
                child: const Text('Task 1'), // Texto del botón.
              ),
              // Botón para ejecutar una tarea en un aislado.
              ElevatedButton(
                onPressed: () async {
                  // Crea un `ReceivePort` para recibir datos del aislado.
                  final receivePort = ReceivePort();
                  // Crea un nuevo aislado y ejecuta la tarea `complexTask2`.
                  await Isolate.spawn(complexTask2, receivePort.sendPort);
                  // Escucha el puerto para recibir los resultados del aislado.
                  receivePort.listen((total) {
                    debugPrint('Result 2: $total'); // Imprime el resultado en la consola.
                  });
                },
                child: const Text('Task 2'), // Texto del botón.
              ),
              // Botón para ejecutar una tarea en un aislado con parámetros.
              ElevatedButton(
                onPressed: () async {
                  // Crea un `ReceivePort` para recibir datos del aislado.
                  final receivePort = ReceivePort();
                  // Crea un nuevo aislado y pasa parámetros a la tarea `complexTask3`.
                  await Isolate.spawn(
                    complexTask3,
                    (
                      iteration: 1000000000, // Número de iteraciones.
                      sendPort: receivePort.sendPort // Puerto para enviar el resultado.
                    ),
                  );
                  // Escucha el puerto para recibir los resultados del aislado.
                  receivePort.listen((total) {
                    debugPrint('Result 3: $total'); // Imprime el resultado en la consola.
                  });
                },
                child: const Text('Task 3'), // Texto del botón.
              )
            ],
          ),
        ),
      ),
    );
  }

  // Tarea compleja que se ejecuta de manera síncrona en el hilo principal.
  Future<double> complexTask1() async {
    var total = 0.0;
    for (var i = 0; i < 1000000000; i++) {
      total += i;
    }
    return total;
  }
}

// Tarea compleja que bloquea la interfaz principal.
Future<double> complexTask1() async {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  return total;
}

// Tarea que se ejecuta en un aislado y envía el resultado mediante un `SendPort`.
complexTask2(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total); // Envía el resultado al puerto principal.
}

// Tarea en un aislado que recibe parámetros.
complexTask3(({int iteration, SendPort sendPort}) data) {
  var total = 0.0;
  for (var i = 0; i < data.iteration; i++) {
    total += i;
  }
  data.sendPort.send(total); // Envía el resultado al puerto principal.
}
