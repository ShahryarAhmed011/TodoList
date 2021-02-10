import 'package:flutter/material.dart';
import 'package:todo_list/routes.dart';

void main() {
  runApp(AppMain());
}

class AppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do List',
        routes: Routes.routes(),
        initialRoute: Routes.initial());
  }
}
