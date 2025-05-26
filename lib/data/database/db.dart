import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'foodshop.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_user);
    await db.execute(_restaurant);
    await db.execute(_product);

    await _insertInitialData(db);
  }

  String get _user => '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      document TEXT NOT NULL,
      password TEXT NOT NULL
    );
  ''';

  String get _restaurant => '''
    CREATE TABLE restaurants (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      cnpj TEXT NOT NULL UNIQUE,
      name TEXT NOT NULL,
      street TEXT NOT NULL,
      number TEXT NOT NULL,
      neighborhood TEXT NOT NULL,
      city TEXT NOT NULL,
      state TEXT NOT NULL,
      zip_code TEXT NOT NULL,
      complement TEXT,
      brand TEXT NOT NULL
    );
  ''';

  String get _product => '''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      restaurant_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      description TEXT,
      price REAL NOT NULL,
      image TEXT,
      FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
    );
  ''';

  Future<void> _insertInitialData(Database db) async {
    List<Map<String, dynamic>> restaurants = [
      {
        'cnpj': '12345678000101',
        'name': 'Pizzaria Itália',
        'street': 'Rua das Flores',
        'number': '100',
        'neighborhood': 'Centro',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '01000-000',
        'complement': '',
        'brand': 'Pizzaria',
      },
      {
        'cnpj': '22345678000102',
        'name': 'Sushi House',
        'street': 'Avenida Japão',
        'number': '200',
        'neighborhood': 'Liberdade',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '01500-000',
        'complement': '',
        'brand': 'Sushi',
      },
      {
        'cnpj': '32345678000103',
        'name': 'Burger Town',
        'street': 'Rua dos Hamburgueres',
        'number': '300',
        'neighborhood': 'Vila Madalena',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '05400-000',
        'complement': '',
        'brand': 'Burger',
      },
      {
        'cnpj': '42345678000104',
        'name': 'Churrascaria Brasil',
        'street': 'Avenida das Nações',
        'number': '400',
        'neighborhood': 'Itaim Bibi',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '04500-000',
        'complement': '',
        'brand': 'Churrasco',
      },
      {
        'cnpj': '52345678000105',
        'name': 'Pastel & Cia',
        'street': 'Praça da República',
        'number': '500',
        'neighborhood': 'República',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '01200-000',
        'complement': '',
        'brand': 'Pastel',
      },
    ];

    for (var restaurant in restaurants) {
      int restaurantId = await db.insert('restaurants', restaurant);

      List<Map<String, dynamic>> products = [
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['brand']} Produto 1',
          'description': 'Descrição do Produto 1',
          'price': 19.99,
          'image': '',
        },
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['brand']} Produto 2',
          'description': 'Descrição do Produto 2',
          'price': 29.99,
          'image': '',
        },
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['brand']} Produto 3',
          'description': 'Descrição do Produto 3',
          'price': 39.99,
          'image': '',
        },
      ];

      for (var product in products) {
        await db.insert('products', product);
      }
    }
  }
}
