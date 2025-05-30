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
    final path = join(await getDatabasesPath(), 'foodshop.db');

    //descomentar se quiser apagar o database
    await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_user);
    await db.execute(_restaurant);
    await db.execute(_product);

    await db.execute(_order);
    await db.execute(_orderItem);

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

  String get _order => '''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      restaurant_id INTEGER NOT NULL,
      user_address_id INTEGER,
      delivery_type TEXT NOT NULL,
      status TEXT NOT NULL,
      total_price REAL NOT NULL,
      paid_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
      FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
      FOREIGN KEY (user_address_id) REFERENCES user_addresses(id) ON DELETE SET NULL
    );
''';

  String get _orderItem => '''
    CREATE TABLE order_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      quantity INTEGER NOT NULL,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
      FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
    );
  ''';

  Future<void> _insertInitialData(Database db) async {
    List<Map<String, dynamic>> restaurants = [
      {
        'cnpj': '12345678000101',
        'name': 'Bardaco Itália',
        'street': 'Rua das Flores',
        'number': '100',
        'neighborhood': 'Centro',
        'city': 'São Paulo',
        'state': 'SP',
        'zip_code': '01000-000',
        'complement': '',
        'brand': 'assets/bitcoin.png',
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
        'brand': 'assets/cardano.png',
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
        'brand': 'assets/ethereum.png',
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
        'brand': 'assets/litecoin.png',
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
        'brand': 'assets/usdcoin.png',
      },
    ];

    for (var restaurant in restaurants) {
      int restaurantId = await db.insert('restaurants', restaurant);

      List<Map<String, dynamic>> products = [
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['name']} Produto 1',
          'description': 'Descrição do Produto 1',
          'price': 19.99,
          'image': '',
        },
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['name']} Produto 2',
          'description': 'Descrição do Produto 2',
          'price': 29.99,
          'image': '',
        },
        {
          'restaurant_id': restaurantId,
          'name': '${restaurant['name']} Produto 3',
          'description': 'Descrição do Produto 3',
          'price': 39.99,
          'image': '',
        },
      ];

      for (var product in products) {
        await db.insert('products', product);
      }
    }

    await db.insert('users', {
      'name': 'Isabella Novaes',
      'email': 'bella@hotmail.com',
      'document': '52511377888',
      'password': '123456',
    });

    await db.insert('users', {
      'name': 'Maria Oliveira',
      'email': 'maria@hotmail.com',
      'document': '52511377888',
      'password': '111222',
    });
  }
}
