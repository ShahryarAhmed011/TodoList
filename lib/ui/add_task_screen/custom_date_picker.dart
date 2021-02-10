import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class CustomDatePicker extends StatelessWidget {
  //Callback types
  //final VoidCallback myVoidCallback = () {};
  //final ValueGetter<int> myValueGetter = () => 42;
  //final ValueSetter<int> myValueSetter = (value) {};

  final ValueSetter<DateTime> _selectedDate;

  CustomDatePicker(this._selectedDate);

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
                      //_taskDate = date;
                      _selectedDate.call(date);
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
}
