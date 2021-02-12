import 'package:flutter/material.dart';
import 'package:todo_list/ui/home_screen/custom_drop_down_menu.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    return Container(
      height: appBar.preferredSize.height,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    //child: Text('1'),
                    //color: Constants.randomColor(),
                    )),
            Expanded(
                flex: 1,
                child: Container(
                    // child: Text('2'),
                    //color: Constants.randomColor(),
                    )),
            Expanded(
              flex: 1,
              child: Container(
                child: CustomDropDownMenu(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBar.preferredSize.height,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    //child: Text('1'),
                    //color: Constants.randomColor(),
                    )),
            Expanded(
                flex: 1,
                child: Container(
                    // child: Text('2'),
                    //color: Constants.randomColor(),
                    )),
            Expanded(
              flex: 1,
              child: Container(
                child: CustomDropDownMenu(),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
*/
