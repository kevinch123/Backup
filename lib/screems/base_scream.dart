import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparente para que se vea la imagen
        elevation: 0, // Sin sombra para un diseño limpio
        title: const Text(
          'Backup',
          style: TextStyle(
            fontSize: 32, // Tamaño grande para un título destacado
            fontWeight: FontWeight.bold, // Negrita para destacar
            color: Colors.orange, // Color personalizado
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // Extiende el cuerpo detrás del AppBar
      body: Stack(
        children: [
          Image.asset(
            'assets/img/parrilla.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Asegúrate de cubrir toda la pantalla
          ),
          SafeArea( // Asegura que el contenido no se superponga con la barra de estado
            child: child,
          ),
        ],
      ),
    );
  }
}
