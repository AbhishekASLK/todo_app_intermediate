import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';
import 'package:todo_app_intermediate/todo_app.dart';

// ====================== DATABASE ================================
dynamic database;
List<ToDoModelClass> tasksFromDB = [];
bool emptyList = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'TodoDB'),
    version: 1,
    onCreate: (db, version) {
      db.execute(
        '''
        CREATE TABLE TaskTable(title TEXT PRIMARY KEY,description TEXT,date TEXT)
      ''',
      );
    },
  );

  tasksFromDB = await getTasks();
  if (tasksFromDB.isNotEmpty) {
    emptyList = false;
  }

  runApp(const MainApp());
}

Future insertTask(ToDoModelClass obj) async {
  final localDB = await database;
  localDB.insert(
    'TaskTable',
    obj.taskMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future getTasks() async {
  final localDB = await database;
  List<Map<String, dynamic>> listOfMap = await localDB.query('TaskTable');

  return List.generate(
    listOfMap.length,
    (index) {
      return ToDoModelClass(
        title: listOfMap[index]['title'],
        description: listOfMap[index]['description'],
        date: listOfMap[index]['date'],
      );
    },
  );
}

Future deleteTasks(String title) async {
  final localDB = await database;

  await localDB.delete(
    'TaskTable',
    where: 'title = ?',
    whereArgs: [title],
  );
}

Future<void> updateTask(ToDoModelClass obj) async {
  final db = await database;

  await db.update(
    'TaskTable',
    obj.taskMap(),
    where: 'title = ?',
    whereArgs: [obj.title],
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    );
  }
}
