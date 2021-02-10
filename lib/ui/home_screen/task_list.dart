import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Constants.dart';
import 'package:todo_list/databasehelper/database_helper.dart';
import 'package:todo_list/models/task.dart';

import 'file:///E:/S.A/Test/todo_list/lib/ui/add_task_screen/add_task_screen.dart';
import 'file:///E:/S.A/Test/todo_list/lib/ui/add_task_screen/custom_dialog.dart';
import 'file:///E:/S.A/Test/todo_list/lib/ui/home_screen/card_check_box.dart';

class TaskList extends StatefulWidget {
  final TextEditingController searchController;

  TaskList(this.searchController);

  @override
  _TaskListState createState() => _TaskListState(searchController);
}

class _TaskListState extends State<TaskList> {
  TextEditingController searchController;
  Future<List<Task>> taskItems;
  DateTime taskDate;
  String dropDownValue;
  String dropHintValue;
  List<String> categoriesList;
  DBHelper dbHelper;

  _TaskListState(TextEditingController searchController) {
    this.searchController = searchController;
  }

  @override
  void initState() {
    //DBHelper().submit();
    // getData();
    //DBHelper().deleteAllTask();
    //DBHelper().getDBRowCount();
    // DBHelper().submit();
    //int dbRow =  DBHelper().getDBRowCount();
    // mTextEditingController.addListener(_printLatestValue);
    dropDownValue = 'Default';
    dropHintValue = 'Default';
    categoriesList = [
      'Default',
      'Personal',
      'Shopping',
      'Wishlist',
      'Work',
    ];

    dbHelper = DBHelper();
    taskDate = DateTime.now();
    searchController.addListener(_printLatestValue);
    taskItems = getTaskList();
    initializeDateFormatting();

    super.initState();
  }

  _printLatestValue() async {
    if (searchController.text == '') {
      setState(() {
        taskItems = getTaskList();
      });
    } else {
      setState(() {
        taskItems = dbHelper.getSearchTask(searchController.text);
      });
    }
  }

  void search(String s) {
    dbHelper.getSearchTask(s);
  }

  Future<List<Task>> getTaskList() async {
    if (await dbHelper.getRowCount() > 0) {
      return await dbHelper.fetchTaskList();
    } else {
      List<Task> taskList = List();
      return taskList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10),
              child: FutureBuilder<List<Task>>(
                future: taskItems,
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
                    if (snapShot.hasData && snapShot.data.isNotEmpty)
                      return _listView(snapShot.data);
                    else //`snapShot.hasData` can be false if the `snapshot.data` is null
                      return _showEmptyList();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                child: Icon(
                  Icons.add_chart,
                  color: Color(0xff607d8b),
                  size: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add new task',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff607d8b)),
              ),
            ],
          )),
          Container(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, Add_Task_Screen);
              },
              color: Colors.white,
            ),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Constants.THEME_COLOR),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget _listView(List<Task> taskItems) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              final item = taskItems[index];
              return Column(
                children: [
                  _taskListCard(item, context),
                ],
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, Add_Task_Screen).then((value) {
                  refreshList();
                });
              },
              color: Colors.white,
            ),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Constants.THEME_COLOR),
          ),
        )
      ],
    );
  }

  Widget _taskListCard(Task item, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)))),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            _title(item),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            _date(item),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Row(
                          children: [
                            Text(
                              item.category,
                              style: TextStyle(
                                  color: Constants.randomColor(),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )),
                        Row(
                          children: [
                            CheckBox(item),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  CustomDialog().showDeleteDialog(context, item,
                                      () {
                                    setState(() {
                                      taskItems = getTaskList();
                                    });
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  //                   <--- left side
                  color: Constants.randomColor(),
                  //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  width: 6.0,
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
          ),
        ),
        SizedBox(
          height: 14,
        )
      ],
    );
  }

  Widget _date(Task item) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            child: RichText(
              //textAlign: TextAlign.justify,
              softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 1,
              text: TextSpan(
                text: DateFormat("EEEE, d, hh:mm:ss:a")
                    .format(item.date)
                    .toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title(Task item) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            child: RichText(
              //justify,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              text: TextSpan(
                text: item.title,
                style: TextStyle(
                  color: Constants.THEME_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void refreshList() {
    setState(() {
      taskItems = getTaskList();
    });
  }
}
