import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/invoice.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'invoices.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE invoices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subtotal REAL,
        discount REAL,
        paymentMethod TEXT,
        total REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceId INTEGER,
        name TEXT,
        quantity INTEGER,
        price REAL,
        imageUrl TEXT,
        FOREIGN KEY (invoiceId) REFERENCES invoices (id)
      )
    ''');
  }

Future<int> insertInvoice(Invoice invoice) async {
  final db = await database;
  print('Guardando en DB: Subtotal=${invoice.subtotal}, Total=${invoice.total}, Discount=${invoice.discount}');
  
  final invoiceId = await db.insert('invoices', {
    'subtotal': invoice.subtotal,
    'discount': invoice.discount,
    'total': invoice.total,
  });

  return invoiceId;
}


Future<List<Invoice>> getInvoices() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('invoices');

  print('Datos recuperados de la DB: $maps');

  return List.generate(maps.length, (i) {
    return Invoice(
      subtotal: maps[i]['subtotal'],
      discount: maps[i]['discount'],
      total: maps[i]['total'], // Validar que esto no sea nulo
      items: [], // Productos vacíos por ahora
    );
  });
}

  
}
