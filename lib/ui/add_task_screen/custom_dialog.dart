import 'package:flutter/material.dart';
import 'package:todo_list/Constants.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_list/databasehelper/database_helper.dart';
import 'package:todo_list/models/task.dart';



class CustomDialog {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  String dropDownValue = 'Default';
  String dropHintValue = 'Default';
  DateTime taskDate = DateTime.now();
  List<String> categoriesList = [
    'Default',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
  ];

  void showFormDialog(BuildContext context,Function formDialogListener) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
                child: Container(
                  width: size.width,
                  height: size.height / 1.5,
                  child: dialogForm(context,formDialogListener),
                  color: Colors.white,
                )),
          );
        });
  }
  Widget dialogForm(BuildContext context,Function formDialogListener){
    return  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _titleController,
//                                        cursorColor: Theme.of(context).cursorColor,
                          //  initialValue: '',
                          decoration: InputDecoration(
                            labelText: 'What is to be done?',
                            labelStyle: TextStyle(
                                color: Constants.THEME_COLOR,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.THEME_COLOR),
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
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
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
                              borderSide: BorderSide(
                                  color: Constants.THEME_COLOR),
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
                _customDropDown(),
                SizedBox(
                  height: 10,
                ),
                _datePicker(),
              ],
            ),
          ),
          Expanded(
            flex: 1,child: _formDialogButtons(context,formDialogListener),
          ),
        ]);
  }
  Widget _customDropDown(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: _dialogText('Select Category',null,FontWeight.bold,Constants.THEME_COLOR,),
              ),
              //IconButton(icon: Icon(Icons.mic,color: Constants.THEME_COLOR,), onPressed: (){}),
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
                hintText: dropHintValue,
                fillColor: Colors.white,
              ),
              value: dropDownValue,
              onChanged: (String value) {
                dropDownValue = value;
              },
              items: categoriesList
                  .map((cityTitle) => DropdownMenuItem(
                  value: cityTitle,
                  child: Text("$cityTitle")))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _datePicker(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Due Date',
                  style: TextStyle(
                      color: Constants.THEME_COLOR,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //IconButton(icon: Icon(Icons.mic,color: Constants.THEME_COLOR,), onPressed: (){}),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: CalendarTimeline(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year, 11, 31),
                    onDateSelected: (date) {
                      taskDate = date;
                    },
                    leftMargin: 20,
                    monthColor: Colors.blueGrey,
                    dayColor: Constants.THEME_COLOR,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: Constants.THEME_COLOR,
                    dotsColor: Color(0xFF333A47),
                    selectableDayPredicate: (date) =>
                    date.day != 23,
                    locale: 'en_ISO',
                  )),
              //IconButton(icon: Icon(Icons.mic,color: Constants.THEME_COLOR,), onPressed: (){}),
            ],
          ),
        ),
      ],
    );
  }
  Widget _formDialogButtons(BuildContext context,Function formDialogListener){
    return Center(
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // this will take space as minimum as posible(to center)
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
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
                  if (_titleController.text == '') {
                    print('Text is empty');
                  } else {
                    Task task = Task.WOID(
                        _titleController.value.text,
                        _descriptionController.text.toString(),
                        taskDate,
                        false,
                        dropDownValue,
                        false);
                    DBHelper().submit(task);
                    formDialogListener.call();


                    /* setState(() {
                                        list getTaskList();
                                      });*/
                    dropDownValue = 'Default';
                    dropHintValue = 'Default';
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void showDeleteDialog(BuildContext context,Task task,Function deleteDialogListener) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: _dialogText('Alert',null, null,null),
          content: _dialogText('Are you sure you want to delete this task?',null,null,null),
          actions: <Widget>[
            //  buttons at the bottom of the dialog
            ElevatedButton(
              child: _dialogText('Close',null,null,null),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            ElevatedButton(
              child: _dialogText("Delete",null,null,null),
              onPressed: () async {
                DBHelper().deleteItem(task.id);
                deleteDialogListener.call();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _dialogText(String text,double fontSize, FontWeight fontWeight,Color textColor){
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

}




