import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const Color THEME_COLOR = const Color(0xff5B5EA6); //Blue Izis
  static const Color THEME_TEXT_COLOR = const Color(0xffffffff); //Blue Izis
  static const Color THEME_TEXT_HINT_COLOR =
      const Color(0xff000000); //Blue Izis
  static const String DATE_TIME_FORMATE = 'EEEE, d MMM, yyyy hh:mm a';

  static const List<String> categoriesList = [
    'All',
    'Default',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
  ];

  static Color randomColor() {
    //return Color(Random().nextInt(0xffffffff));
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
