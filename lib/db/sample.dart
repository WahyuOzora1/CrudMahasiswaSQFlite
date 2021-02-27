// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'dart:async';
//
// class DatabaseHelper {
//   static Database _database;
//   Future<Database> get database async {
//     // if (_database != null) return _database;
//     _database = await initDb();
//     return _database;
//   }
//
//   Future<Database> initDb() async {
//     var directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, "$nameDb");
//
//     print("Path $path");
//
//     return openDatabase(path, version: 1, onCreate: onCreateDb);
//   }
//
//   // Create Table
//   void onCreateDb(Database db, int version) async {
//     await createTbTask(db);
//   }
//
//   Future deleteDb() async {
//     var directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, "$nameDb");
//     await deleteDatabase(path);
//   }
//
//   // Clean All Data
//   Future cleanAllData(Database db, String nameTable) async {
//     return await db.transaction((txn) async {
//       var batch = txn.batch();
//       batch.delete("$nameTable");
//       await batch.commit();
//     });
//   }
//
//   Future createTbTask(Database db) async {
//     // Create Table Task
//     try {
//       await db.execute('''
//       CREATE TABLE $tableTask (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_task TEXT
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableTask Create $e");
//     }
//
//     // Create Table Linked
//     try {
//       await db.execute('''
//       CREATE TABLE $tableLinked (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_task TEXT
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableLinked Create $e");
//     }
//
//     // Create Table Progress
//     try {
//       await db.execute('''
//       CREATE TABLE $tableProgress (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_progress TEXT DEFAULT NULL
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableProgress Create $e");
//     }
//
//     // Create Table Task Type
//     try {
//       await db.execute('''
//       CREATE TABLE $tableTaskType (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_task_type TEXT DEFAULT NULL
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableTaskType Create $e");
//     }
//
//     // Create Table Checklist
//     try {
//       await db.execute('''
//       CREATE TABLE $tableChecklist (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_checklist TEXT DEFAULT NULL
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableChecklist Create $e");
//     }
//
//     // Create Table Submit Checklist
//     try {
//       await db.execute('''
//       CREATE TABLE $tableSubmitChecklist (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data_submit_checklist TEXT DEFAULT NULL
//         )
//     ''');
//     } catch (e) {
//       print("Exception Table $tableSubmitChecklist Create $e");
//     }
//   }
// }
//
// final dbHelper = DatabaseHelper();
