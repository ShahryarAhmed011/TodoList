import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Task{

  int _id;
  String _title;
  String _description;
  DateTime _date;
  String _category;
  bool _taskStatus;
  bool _completed;

  Task(this._id, this._title, this._description, this._date, this._taskStatus, this._category, this._completed);
  Task.WOID(this._title, this._description, this._date, this._taskStatus, this._category, this._completed);

  bool get completed => _completed;

  set completed(bool value) {
    _completed = value;
  }

  bool get taskStatus => _taskStatus;

  set taskStatus(bool value) {
    _taskStatus = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toJson() =>
      {
        'id': _id,
        'title': _title,
        'description': _description,
        'date': _date,
        'category': _category,
        'status': _taskStatus,
        'is_complete': _completed,
      };


/*
  Task({this.id, this.title, this.description, this.date, this.taskStatus = false, this.category,
      this.completed = false}){
    if(id==null){
      id=_uuid.v4();
    }
  }
*/

 /* @override
  String toString() {
    return 'Task(description: $description, completed: $completed)';
  }*/




}