import 'package:flutter/material.dart';
import 'package:todo_list/Constants.dart';
import 'package:todo_list/databasehelper/database_helper.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/ui/add_task_screen/custom_date_picker.dart';

const String Add_Task_Screen = 'Add_Task_Screen';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  String _dropDownValue;
  DateTime _taskDate;
  bool _validate;

  @override
  void initState() {
    _titleController = new TextEditingController();
    _descriptionController = new TextEditingController();
    _dropDownValue = 'Default';
    _validate = false;
    _taskDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Task'),
        backgroundColor: Constants.THEME_COLOR,
      ),
      body: taskForm(context),
    );
  }

  Widget taskForm(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            errorText:
                                _validate ? 'Value Can\'t Be Empty' : null,
                            labelText: 'What is to be done?',
                            labelStyle: TextStyle(
                                color: Constants.THEME_COLOR,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.THEME_COLOR),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _descriptionController,
                          // cursorColor: Theme.of(context).cursorColor,
                          // initialValue: '',
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Constants.THEME_COLOR,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.THEME_COLOR),
                            ),
                          ),
                        ),
                      ),
                      //IconButton(icon: Icon(Icons.mic,color: Constants.THEME_COLOR,), onPressed: (){}),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropDownMenu(
                  selectedItem: (item) {
                    _dropDownValue = item;
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                /*CustomDatePicker((selectedDate) {
                  _taskDate = selectedDate;
                }
                ),*/

                CustomDateTimePicker((selectedDate) {
                  print('Task Date Time-->$selectedDate');
                  _taskDate = DateTime.parse(selectedDate);
                }),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: AddTaskButtons(
              onSaveButton: () {
                if (_titleController.text == '') {
                  setState(() {
                    _titleController.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                } else {
                  Task task = Task.WOID(
                      _titleController.value.text,
                      _descriptionController.text.toString(),
                      _taskDate,
                      false,
                      _dropDownValue,
                      false);
                  DBHelper().submit(task);

                  Navigator.pop(context);
                }
              },
              onCloseButton: () => Navigator.pop(context),
            ),
          ),
        ]);
  }

  Widget _dialogText(
      String text, double fontSize, FontWeight fontWeight, Color textColor) {
    return Text(
      text,
      style: TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  @override
  void dispose() {
    _titleController.clear();
    _descriptionController.clear();
    _dropDownValue = 'Default';
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class AddTaskButtons extends StatelessWidget {
  final VoidCallback onSaveButton;
  final VoidCallback onCloseButton;

  AddTaskButtons({this.onSaveButton, this.onCloseButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: new Text('Close'),
                onPressed: () {
                  onCloseButton.call();
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: ElevatedButton(
                child: new Text('Save'),
                onPressed: () {
                  onSaveButton.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropDownMenu extends StatelessWidget {
  final ValueSetter<String> selectedItem;
  final String _dropDownValue = 'Default';
  final String _dropHintValue = 'Default';

  CustomDropDownMenu({this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Select Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.THEME_COLOR)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  //                   <--- left side
                  color: Constants.randomColor(),
                  width: 0.2,
                ),
                right: BorderSide(
                  //                   <--- left side
                  color: Constants.randomColor(),
                  width: 0.2,
                ),
                top: BorderSide(
                  //                   <--- left side
                  color: Constants.randomColor(),
                  width: 0.2,
                ),
                bottom: BorderSide(
                  //                   <--- left side
                  color: Constants.randomColor(),
                  width: 0.2,
                ),
              ),
            ),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: _dropHintValue,
                fillColor: Colors.white,
              ),
              value: _dropDownValue,
              onChanged: (String value) {
                selectedItem.call(value);
              },
              items: Constants.categoriesList
                  .map((cityTitle) => DropdownMenuItem(
                      value: cityTitle, child: Text("$cityTitle")))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

/*class CustomDateTimePicker extends StatelessWidget {
  final ValueSetter selectedDateTime;

  CustomDateTimePicker(this.selectedDateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: DateTimePicker(
        type: DateTimePickerType.dateTime,
        dateMask: Constants.DATE_TIME_FORMATE,
        initialValue: DateTime.now().toString(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 11, 31),
        dateLabelText: 'Date',
        timeLabelText: "Hour",
        */ /*selectableDayPredicate: (date) {
          // Disable weekend days to select from the calendar
          if (date.weekday == 6 || date.weekday == 7) {
            return false;
          }
          return true;
        },*/ /*
        onChanged: (val) => selectedDateTime.call(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print(val),
      ),
    );
  }
}*/
