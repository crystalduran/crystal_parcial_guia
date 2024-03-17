import 'package:crystal_examen_2/models/evento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const int _version = 1;
  static const String _dbname = "Emergencias.db";
  static DatabaseHelper? _instance;

  DatabaseHelper._(); //Constructor privado para evitar instanciacion directa de DatabaseHelper

  // Método estático para obtener la instancia única de DatabaseHelper utilizando inicialización perezosa
  static DatabaseHelper getInstance() {
    _instance ??= DatabaseHelper._(); //esto es inicializacion perezosa de la instancia
    return _instance!;
  }

  //Metodo privado para obtener la base de datos
  Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbname), //// Abre la base de datos en la ruta especificada
      onCreate: (db, version) async => // Define la creación de la base de datos si no existe
          await db.execute(
            "CREATE TABLE Eventos(id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt INTEGER NOT NULL, titulo TEXT NOT NULL, descripcion TEXT NOT NULL, image64bit TEXT);"),
          version: _version
    );
  }

  //metodo para agregar eventos
  static Future<int> insertEvento(Evento evento) async {
    final db = await getInstance()._getDB();
    return await db.insert("Eventos", evento.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Método estático para actualizar un evento en la base de datos
  static Future<int> updateEvento(Evento evento) async {
    final db = await getInstance()._getDB();
    //copia del producto original sin el campo createdAt
    final Map<String, dynamic> eventoMap = Map.from(evento.toJson());
    eventoMap.remove('createdAt');

    return await db.update("Eventos", eventoMap,
        where: 'id = ?', whereArgs: [evento.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Método estático para eliminar un evento de la base de datos
  static Future<int> deleteEvento(Evento evento) async {
    final db = await getInstance()._getDB();
    return await db.delete("Eventos",
    where: 'id = ?', whereArgs: [evento.id]);
  }

  // Método estático para obtener todos los eventos de la base de datos
  static Future<List<Evento>?> getAllEventos() async {
    final db = await getInstance()._getDB();
    final List<Map<String, dynamic>> maps = await db.query("Eventos");

    if(maps.isEmpty){
      return null;
    }

    return List.generate(maps.length, (index) => Evento.fromJson(maps[index]));
  }

}