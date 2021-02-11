import 'package:flutter/material.dart';
import 'package:todo_list/Constants.dart';
import 'package:todo_list/models/stream_helper.dart';
import 'package:todo_list/ui/home_screen/search_field.dart';

import 'digital_clock.dart';
import 'task_list.dart';

const String HOME_SCREEN = 'Home_Screen';
typedef SearchTextCallback = Function(TextEditingController); //forCallback

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('.'),
          elevation: 0,
          backgroundColor: Constants.THEME_COLOR,
          centerTitle: true,
          leading: Icon(
            Icons.menu,
          ),
          actions: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.settings,
                color: Constants.THEME_TEXT_COLOR,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        body: Home(),
        backgroundColor: Constants.THEME_COLOR,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          elevation: 10,
          backgroundColor: Constants.THEME_COLOR,
          onPressed: () {
            StreamHelper().controller.add(1);
          },
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: Constants.THEME_COLOR,
              child: Center(
                child: _screenTop(context),
              ),
            )),
        Expanded(
          flex: 6,
          child: _screenBottom(),
        ),
      ],
    );
  }

  Widget _screenTop(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 4,
            child: Container(
              /*color: Colors.amber,*/
              child: DigitalClock(),
            )),
        Expanded(
            flex: 3,
            child: Container(
              child: Center(child: SearchField(searchController)),
            )),
      ],
    );
  }

  Widget _screenBottom() {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(60.0),
            topRight: const Radius.circular(60.0),
          )),
      child: TaskList(searchController: searchController),
    );
  }
}
