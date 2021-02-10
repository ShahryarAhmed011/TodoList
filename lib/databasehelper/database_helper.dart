import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/models/task.dart';

class DBHelper{

  static final _dbName = 'todolist.db';
  static final _dbVersion = 1;
  static final _TABLE_NAME = 'task';

  static final TASK_ID = 'id';
  static final TASK_TITLE = 'title';
  static final TASK_DESCRIPTION = 'description';
  static final TASK_DATE = 'date';
  static final TASK_CATEGORY = 'category';
  static final TASK_STATUS = 'status';
  static final TASK_COMPLETE = 'is_complete';
  static Database _db;
  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    var theDb = await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE $_TABLE_NAME($TASK_ID INTEGER PRIMARY KEY, $TASK_TITLE TEXT, $TASK_DESCRIPTION TEXT, $TASK_DATE TEXT,$TASK_CATEGORY TEXT, $TASK_STATUS TEXT, $TASK_COMPLETE TEXT )");
    print("Created tables");
  }

  // Retrieving employees from Employee Tables
  Future<List<Task>> getTask() async {
    var dbClient = await db;
    List<Map>  list = await dbClient.rawQuery('SELECT * FROM $_TABLE_NAME');
    List<Task> taskList = new List();
    for (int i = 0; i < list.length; i++) {
      //print('List In DB Helper--->${list[i]["$TASK_COMPLETE"]}');
     // print('List In DB Helper stringToBool--->${stringToBool(list[i][" $TASK_COMPLETE"])}');
    //  print('List In DB Helper stringToBool--->${toBoolean(list[i]["$TASK_COMPLETE"])}');
      taskList.add(new Task(list[i]["$TASK_ID"], list[i]["$TASK_TITLE"], list[i]["$TASK_DESCRIPTION"], DateTime.parse(list[i]["$TASK_DATE"]), toBoolean(list[i]["$TASK_STATUS"]) ,list[i]["$TASK_CATEGORY"], toBoolean(list[i]["$TASK_COMPLETE"])));/*stringToBool(list[i]["$TASK_STATUS"]), list[i]["$TASK_CATEGORY"]*///stringToBool(list[i][" $TASK_COMPLETE"])));
    }
    print(taskList.length);
    return taskList;
  }

  Future<List<Task>> getSearchTask(String s) async {
    var dbClient = await db;// await dbClient.rawQuery('SELECT * FROM task WHERE name LIKE ', [s]);
    List<Map>  list =  await dbClient.rawQuery('SELECT * FROM $_TABLE_NAME');
    List<Task> taskList = new List();
    List<Task> filteredList = new List();

    for (int i = 0; i < list.length; i++) {
    //  print('Search List In DB Helper--->${list[i]["$TASK_TITLE"]}');
      // print('List In DB Helper stringToBool--->${stringToBool(list[i][" $TASK_COMPLETE"])}');
      //  print('List In DB Helper stringToBool--->${toBoolean(list[i]["$TASK_COMPLETE"])}');
      if(list[i]["$TASK_TITLE"].toString().toLowerCase().contains(s.toLowerCase())){
        filteredList.add(new Task(list[i]["$TASK_ID"], list[i]["$TASK_TITLE"], list[i]["$TASK_DESCRIPTION"], DateTime.parse(list[i]["$TASK_DATE"]), toBoolean(list[i]["$TASK_STATUS"]) ,list[i]["$TASK_CATEGORY"], toBoolean(list[i]["$TASK_COMPLETE"])));/*stringToBool(list[i]["$TASK_STATUS"]), list[i]["$TASK_CATEGORY"]*///stringToBool(list[i][" $TASK_COMPLETE"])));
      }
     }
    print(filteredList.length);
    return filteredList;
  }

  Future<Task> getSingleRecord(int id) async {
    var dbClient = await db;
    List<Map>  list = await dbClient.rawQuery('SELECT * FROM $_TABLE_NAME WHERE $TASK_ID = $id');
    Task task;
    for (int i = 0; i < list.length; i++) {
    task = new Task(list[i]["$TASK_ID"], list[i]["$TASK_TITLE"], list[i]["$TASK_DESCRIPTION"], DateTime.parse(list[i]["$TASK_DATE"]), toBoolean(list[i]["$TASK_STATUS"]) ,list[i]["$TASK_CATEGORY"], toBoolean(list[i]["$TASK_COMPLETE"]));/*stringToBool(list[i]["$TASK_STATUS"]), list[i]["$TASK_CATEGORY"]*///stringToBool(list[i][" $TASK_COMPLETE"])));
  }
    return task;
  }

  bool toBoolean(String boolString){
   // print(boolString);
    if(boolString.toString() == "true"){
     // print('Identical is true');
      return true;
    }else{
     // print('Identical is false $boolString == ${"true"}');
      return false;
    }
  }

  void saveTask(Task task) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO $_TABLE_NAME($TASK_TITLE, $TASK_DESCRIPTION, $TASK_DATE, $TASK_CATEGORY, $TASK_STATUS, $TASK_COMPLETE ) VALUES(' +
              '\'' +
              task.title +
              '\'' +
              ',' +
              '\'' +
              task.description +
              '\'' +
              ',' +
              '\'' +
              task.date.toString() +
              '\'' +
              ',' +
              '\'' +
              task.category.toString() +
              '\'' +
              ',' +
              '\'' +
              task.taskStatus.toString() +
              '\'' +
              ',' +
              '\'' +
              task.completed.toString() +
              '\'' +
              ')');
    });
  }



  Future<int> getRowCount() async {
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $_TABLE_NAME'));
    return count;
  }



  deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete("Delete from $_TABLE_NAME");
  }

  deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete("Delete from $_TABLE_NAME WHERE $TASK_ID = $id");
  }

  getDBRowCount() async {
    print('RowCount----${await DBHelper().getRowCount()}');
  }

  Future<List<Task>> fetchTaskList() async {
    var dbHelper = DBHelper();
    Future<List<Task>> task = dbHelper.getTask();
    return task;
  }


  void getTaskList() async{
    List<Task> emp = await fetchTaskList();
    print('Date From DB---->>${emp.elementAt(0).date}');
  }

  void submit(Task task) {
 /*   var json = jsonEncode(task);
    print('Date From Task---->>${task.date}');*/
    var dbHelper = DBHelper();
    dbHelper.saveTask(task);

  }

  void deleteAllTask() async{
    await DBHelper().deleteAll();
  }

  void updateTask(int id,bool isTaskComplete) async{
    var dbClient = await db;
    await dbClient.rawUpdate('''
    UPDATE $_TABLE_NAME 
    SET $TASK_COMPLETE = ? 
    WHERE $TASK_ID = ?
    ''',
        [boolToString(isTaskComplete), id]);  }

  String boolToString(bool boolValue){
    if(boolValue == true){
      return 'true';
    }else{
      return 'false';
    }
  }


}


/*
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper{
  static final _dbName = 'todolist.db';
  static final _dbVersion = 1;
  static final _TABLE_NAME = 'task';

  static final TASK_ID = 'id';
  static final TASK_TITLE = 'title';
  static final TASK_DESCRIPTION = 'description';
  static final TASK_DATE = 'date';
  static final TASK_CATEGORY = 'category';
  static final TASK_STATUS = 'status';
  static final TASK_COMPLETE = 'is_complete';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      print('DB is not null');
      return _database;
    }else{
      print('DB is null');
      _database = await _initiateDatabase();
      return _database;
    }

  }

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    print('-Path--$path');
   return await openDatabase(path,version: _dbVersion,
        onCreate: _onCreate,
    );


    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $_TABLE_NAME ($TASK_ID INTEGER PRIMARY KEY, $TASK_TITLE TEXT, $TASK_DESCRIPTION TEXT, $TASK_DATE TEXT, $TASK_CATEGORY TEXT, $TASK_STATUS TEXT, $TASK_COMPLETE TEXT)');
        });

    return db;

  }

   _onCreate(Database db, int version) async{
    await db.execute(
      """
      CREATE TABLE $_TABLE_NAME ( 
      $TASK_ID INTEGER PRIMARY KEY,
      $TASK_TITLE TEXT NOT NULL,
      $TASK_DESCRIPTION TEXT NOT NULL,
      $TASK_DATE TEXT NOT NULL,
      $TASK_CATEGORY TEXT NOT NULL,
      $TASK_STATUS TEXT NOT NULL,
      $TASK_COMPLETE TEXT NOT NULL);
      """
    );
  }

  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_TABLE_NAME, row);
  }

  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_TABLE_NAME);
  }

  Future<int> update(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id= row[TASK_ID];
    int title= row[TASK_TITLE];
    return await db.update(_TABLE_NAME, row,where:'$TASK_ID = ? $TASK_TITLE',whereArgs: [id,title]);
  }

  Future<int> delete(Map<String,dynamic> row) async{
    Database db = await instance.database;
    int id= row[TASK_ID];
    return await db.delete(_TABLE_NAME,where:'$TASK_ID = ? $TASK_TITLE',whereArgs: [id]);
  }

  checkIfDataExist() async{
    Database db = await instance.database;
    print(db.rawQuery('SELECT COUNT(*) FROM $_TABLE_NAME'));
  }
  void tableIsEmpty()async{
    var db = await instance.database;

    int count = Sqflite
        .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $_TABLE_NAME'));

    print(count);
  }

  Future<int> getcount(id) async {
    var dbclient = await instance.database;
    int  count = Sqflite.firstIntValue(
        await dbclient.rawQuery("SELECT COUNT(*) FROM $_TABLE_NAME WHERE $TASK_ID=$id"));
    return count;
  }
}
*/
