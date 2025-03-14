import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Widgets/Orders.dart';
import 'SQL.dart';

class DatabaseHelper {
  static const _databaseName = "TAT.db";
  static const _databaseVersion = 1;

  Database? _database;

  // Getter for initializing or getting the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database and creates tables if they don't exist
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE location (
        uid TEXT PRIMARY KEY,
        Date TEXT,
        ShopName TEXT,
        useremail TEXT,
        timestamp TEXT,
        total TEXT,
        location TEXT,
        phno TEXT,
        
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        uid TEXT,
        Product TEXT,
        SellingPrice TEXT,
        MRP TEXT,
        Quantity TEXT,
        Free TEXT,
        FOREIGN KEY(uid) REFERENCES location(uid)
      )
    ''');
  }

  // Insert data into location table
  Future<int> insertLocation(Map<String, dynamic> locationData) async {
    final db = await database;
    return await db.insert(locationData["location"], locationData);
  }

  // Insert data into orders table
  Future<int> insertOrder(Map<String, dynamic> orderData) async {
    final db = await database;
    return await db.insert('orders', orderData);
  }

  Future<void> insertLocationWithOrders(SQL sql) async {
    final db = await database;
    print(sql.toMap());
    // Insert into the location table
    await db.insert('location', sql.toMap());
    print("object");
    // Insert each item in the items list into the orders table
    // for (Orders order in sql.items) {
    //   final orderData = order.toMap();
    //   orderData['uid'] = sql.uid; // Set the foreign key `uid`
    //   await db.insert('orders', orderData);
    // }
  }

  void printDatabasePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/TAT.db';
    print("Database path: $dbPath");
  }

  Future<void> printLocationTable(Database db) async {
    final List<Map<String, dynamic>> locations = await db.query('location');
    print("Location Table:");
    for (var row in locations) {
      print(row);
    }
  }

  // Function to get all data from the 'orders' table
  Future<void> printOrdersTable() async {
    final db = _database;
    final List<Map<String, dynamic>> orders = await db!.query('orders');
    print("Orders Table:");
    for (var row in orders) {
      print(row);
    }
  }
}
