import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_intermediate/model/todomodel.dart';
import 'package:todo_app_intermediate/todo_app.dart';

// ====================== DATABASE ================================
dynamic database;
List<ToDoModelClass> tasksFromDB = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'ToDoDB3.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute(
        '''
        CREATE TABLE TaskTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          date TEXT,
          completed INTEGER
        )
      ''',
      );
    },
  );

  tasksFromDB = await getTasks();

  runApp(const MainApp());
}

Future insertTask(ToDoModelClass obj) async {
  final localDB = await database;
  await localDB.insert(
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
          id: listOfMap[index]['id'],
          title: listOfMap[index]['title'],
          description: listOfMap[index]['description'],
          date: listOfMap[index]['date'],
          completed: listOfMap[index]['completed']);
    },
  );
}

Future deleteTasks(int? id) async {
  final localDB = await database;
  await localDB.delete(
    'TaskTable',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> updateTask(ToDoModelClass newObj) async {
  final db = await database;
  await db.update(
    'TaskTable',
    newObj.taskMap(),
    where: 'id = ?',
    whereArgs: [newObj.id],
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
