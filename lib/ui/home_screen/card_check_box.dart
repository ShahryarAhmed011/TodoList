import 'package:flutter/material.dart';
import 'package:todo_list/databasehelper/database_helper.dart';
import 'package:todo_list/models/task.dart';

class CheckBox extends StatefulWidget {
  final Task _task;

  CheckBox(this._task);

  @override
  _CheckBoxState createState() => _CheckBoxState(_task);
}

class _CheckBoxState extends State<CheckBox> {
  Task _task;
  bool isTaskCompleted = false;
  Future<Task> futureTask;

  _CheckBoxState(this._task);

  void initState() {
    //print('State ${_task.completed}');
    futureTask = getUpdatedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Task>(
      future: futureTask,
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapShot.hasError) {
          return Center(
            child: Text("ERROR: ${snapShot.error}"),
          );
        } else {
          if (snapShot.hasData && snapShot.data != null)
            return _checkBox(snapShot.data);
          else //`snapShot.hasData` can be false if the `snapshot.data` is null
            return Text('Something went wrong');
        }
      },
    );
  }

  Widget _checkBox(Task task) {
    return Checkbox(
      value: task.completed,
      onChanged: (bool value) {
        if (task.completed == true) {
          _updateTask(task, false);
          // getUpdatedTask();
          //isTaskCompleted = false;
          //item.completed(true);
        } else {
          _updateTask(task, true);
          //DBHelper().updateTask(task.id,true);
          //getUpdatedTask();
          //isTaskCompleted = true;
          //item.completed(true);
        }
      },
    );
  }

  Future<Task> getUpdatedTask() async {
    Task task = await DBHelper().getSingleRecord(_task.id);
    // print('Updated Task  =  ${task.completed}');
    return task;
  }

  _updateTask(Task task, bool value) async {
    DBHelper().updateTask(task.id, value);
    setState(() {
      futureTask = getUpdatedTask();
    });
  }
}
