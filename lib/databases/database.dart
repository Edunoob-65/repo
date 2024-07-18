import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recetariopersonal/modelos/receta.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recetario.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            correo TEXT NOT NULL UNIQUE,
            contrasena TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE recetas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuarioId INTEGER NOT NULL,
            titulo TEXT NOT NULL,
            ingredientes TEXT NOT NULL,
            pasos TEXT NOT NULL,
            rutaImagen TEXT,
            categoria TEXT NOT NULL,
            FOREIGN KEY (usuarioId) REFERENCES usuarios(id)
          )
        ''');
      },
    );
  }

Future<int> insertarReceta(Receta receta) async {
  final db = await database;
  return await db.insert('recetas', receta.toMap());
}


  // Método para registrar un nuevo usuario
  Future<int> registrarUsuario(String correo, String contrasena) async {
    final db = await database;
    return await db.insert('usuarios', {'correo': correo, 'contrasena': contrasena});
  }

  // Método para obtener un usuario por correo y contraseña
  Future<Map<String, dynamic>?> obtenerUsuario(String correo, String contrasena) async {
    final db = await database;
    var result = await db.query('usuarios',
        where: 'correo = ? AND contrasena = ?', whereArgs: [correo, contrasena]);
    return result.isNotEmpty ? result.first : null;
  }

  // Método para obtener recetas por usuarioId
  Future<List<Receta>> obtenerRecetasPorUsuario(int usuarioId) async {
    final db = await database;
    var result = await db.query('recetas', where: 'usuarioId = ?', whereArgs: [usuarioId]);
    return result.map((json) => Receta.fromMap(json)).toList();
  }
}
