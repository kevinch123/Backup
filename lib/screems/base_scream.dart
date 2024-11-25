import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        title: const Text(
          'Backup',
          style: TextStyle(
            fontSize: 32, 
            fontWeight: FontWeight.bold, 
            color: Colors.orange, 
          ),
        ),
      ),
      extendBodyBehindAppBar: true, 
      body: Stack(
        children: [
          Image.asset(
            'assets/img/parrilla.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, 
          ),
          SafeArea( 
            child: child,
          ),
        ],
      ),
    );
  }
}
