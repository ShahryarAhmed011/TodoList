import 'package:flutter/material.dart';
import 'package:todo_list/Constants.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;

  SearchField(this.searchController);

  @override
  _SearchFieldState createState() => _SearchFieldState(searchController);
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController searchController;

  _SearchFieldState(TextEditingController searchController) {
    this.searchController = searchController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _searchField(context);
  }

  Widget _searchField(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width / 6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 0), // shadow direction: bottom right
                ),
              ],
            ),
            child: TextFormField(
              autofocus: false,
              controller: searchController,
              style: TextStyle(color: Constants.THEME_TEXT_COLOR),
              cursorColor: Constants.THEME_TEXT_COLOR,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                fillColor: Constants.THEME_COLOR,
                filled: true,
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Constants.THEME_TEXT_HINT_COLOR,
                    fontWeight: FontWeight.normal),
                suffixIcon: Icon(
                  Icons.search,
                  color: Constants.THEME_TEXT_COLOR,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.THEME_COLOR,
                    width: 0.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.THEME_COLOR,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
