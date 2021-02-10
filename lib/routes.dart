


import 'file:///E:/S.A/Test/todo_list/lib/ui/add_task_screen/add_task_screen.dart';
import 'package:todo_list/ui/home_screen/home_screen.dart';
import 'package:todo_list/ui/splash_screen.dart';

class Routes{

  static routes(){
    return {
      SPLASH_SCREEN:(context) => SplashScreen(),
      HOME_SCREEN:(context) => HomeScreen(),
      Add_Task_Screen:(context) => AddTaskScreen(),
    //  MyApp.ROUTE_ID:(context) => MyApp(),
    };
  }

  static initial(){
    return HOME_SCREEN;
  }
}