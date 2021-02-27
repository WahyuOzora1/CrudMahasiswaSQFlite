import 'package:crudmahasiswasqflite/db/constant.dart';
import 'package:crudmahasiswasqflite/models/mahasiswa.dart';
import 'package:crudmahasiswasqflite/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  //menginiisialisasi DbHelper
  static final DbHelper _instance = DbHelper._internal();
  static Database _database; //menampung database untuk crud ke sqflite nya

  DbHelper._internal();
  factory DbHelper() => _instance;

  //membuat method untuk mengisi si database

  /// Read database apakah ada atau tidak
  Future<Database> get db async {
    //jika database nya tidak kosong maka ambillah
    // await deleteDb();
    if (_database != null) {
      return _database;
    }
    _database =
        await _initDb(); //pertama aplikasi dibuka memuat databsd dari initDb

    return _database;
  }

  Future<Database> _initDb() async {
    /// Membaca directory di folder root handphone
    String databasePath = await getDatabasesPath();

    /// Membuat file database nya
    String path = join(databasePath, 'mahasiswa.db');

    /// Execute query diatas
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate); //oncreate melakukan apa saja pas buka aplikasi
  }

  Future<void> _onCreate(Database db, int version) async {
    //waktu pertama kali buka aplikasi kalian mau apain

    /// Create Table Mahasiswa
    var sql = "CREATE TABLE $tabelNama ($columnId INTEGER PRIMARY KEY,"
        "$columnNamaDepan TEXT,"
        "$columnNamaBelakang TEXT,"
        "$columnNim TEXT,"
        "$columnProdi TEXT)";

    /// Create Table User
    var sql2 = "CREATE TABLE $tabelUser ($columnIdUser INTEGER PRIMARY KEY,"
        "$columnUsername TEXT,"
        "$columnEmail TEXT,"
        "$columnPassword TEXT)";

    /// Jalankan Query database diatas dengan execute
    await db.execute(sql);
    await db.execute(
        sql2); //database nya akan dibuat berdasarkan kolom" yang dibuat diatas
  }

  /// Delete database
  Future deleteDb() async {
    var directory = await getDatabasesPath();
    var dbClient = await db;
    String path = join(directory, "mahasiswa.db");
    await deleteDatabase(path);
    dbClient.close();
  }

  /// ==== Method Logically Data =====

  //membuat fungsi untuk menyimpan mahasiswa, ini untuk set nya
  Future<int> saveMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await db;
    return await dbClient.insert(tabelNama, mahasiswa.toMap());
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert(tabelUser, user.toMap());
  }

  //ini untuk get nya
  Future<List> getAllMahasiwa() async {
    try {
      var dbClient = await db; //inisialsi
      var result = await dbClient.query(tabelNama, columns: [
        //result digunakan untuk menyimpan database mahasiswa
        columnId,
        columnNamaDepan,
        columnNamaBelakang,
        columnNim,
        columnProdi,
      ]);
      if (result.length > 0 && result != null) {
        return result.toList();
      } else {
        return [];
      }
    } catch (e) {}
  }

  //ini untuk get nya
  Future<List> getAllUser() async {
    var dbClient = await db; //inisialsi
    var result = await dbClient.query(tabelUser, columns: [
      //result digunakan untuk menyimpan database mahasiswa
      columnIdUser,
      columnUsername,
      columnEmail,
      columnPassword
    ]);
    return result.toList();
  }

//method untuk mengupdate data mahasiwa
  Future<int> updateMahasiswa(Mahasiswa mahasiswa) async {
    var dbclient = await db; //sama seperti biasanya kita inisialisasi dulu
    return await dbclient.update(tabelNama, mahasiswa.toMap(),
        where: '$columnId = ?', whereArgs: [mahasiswa.id]);
  }

  Future<int> deleteMahasiwa(Mahasiswa mahasiswa) async {
    var dbClient = await db;
    return await dbClient
        .delete(tabelNama, where: '$columnId=?', whereArgs: [mahasiswa.id]);
  }
}

final dbHelper = DbHelper();
