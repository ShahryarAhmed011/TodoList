import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../Constants.dart';

class DigitalClock extends StatefulWidget {
  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  String date;

  @override
  void initState() {
    super.initState();
    date = DateFormat('EEEE, MMMM d, yyyy')
        .format(DateTime.now()); // f.format(new DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return _timeDateWidget();
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("hh:mm:ss a").format(now);
  }

  Widget _timeDateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
            ),
            TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
              // print("${getSystemTime()}");
              return Text("${getSystemTime()}",
                  style: TextStyle(
                      fontSize: 30,
                      color: Constants.THEME_TEXT_COLOR,
                      fontWeight: FontWeight.w300));
            }),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 25,
            ),
            Text(
              date,
//              'Wednesday, January 27, 2021',
              style: TextStyle(
                  color: Constants.THEME_TEXT_COLOR,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ],
    );
  }
}
