import 'package:backup/screems/accounting_screem.dart';
import 'package:backup/screems/menu_screem.dart';
import 'package:backup/screems/options_screem.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(  
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Mesas',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 20,
                children: List.generate(9, (index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      foregroundColor: Colors.black,
                      shadowColor: Colors.transparent, 
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Options(tableNumber: 'Mesa ${index + 1}'), 
                        ),
                      );
                    },
                    child: Text('${index + 1}'),
                  );
                }),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Options(tableNumber: 'Domicilio'),
                    ),
                  );
                },
                child: Text('Domicilios'),
              ),
              SizedBox(height: 10),

              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreationDishes()),
                      );
                    },
                    child: Text('Crear Menú'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountingScreen()),
                      );
                    },
                    child: Text('Contabilidad'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
