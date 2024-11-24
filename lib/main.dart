import 'package:backup/controller/cart_controller.dart';
import 'package:backup/controller/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:firebase_core/firebase_core.dart'; 
import 'screems/home_screem.dart'; 
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InvoiceController()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      title: 'Menú del Restaurante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), 
    );
  }
}
