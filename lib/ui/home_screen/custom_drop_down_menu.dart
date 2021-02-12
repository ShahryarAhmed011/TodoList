import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:todo_list/Constants.dart';
import 'package:todo_list/models/stream_helper.dart';

class CustomDropDownMenu extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CustomDropDownMenu> {
  String dropDownLabel = 'All';
  @override
  Widget build(BuildContext context) {
    return _customDropDown();
  }

  Widget _customDropDown() {
    return MenuButton(
      child: Container(
        color: Constants.THEME_COLOR,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: RichText(
                    //textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    text: TextSpan(
                      text: dropDownLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      items: Constants.categoriesList, // List of your items
      topDivider: true,
      popupHeight:
          200, // This popupHeight is optional. The default height is the size of items
      scrollPhysics:
          AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
      itemBuilder: (value) => Container(
          width: 83,
          height: 40,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(value)), // Widget displayed for each item
      toggledChild: Container(
        color: Constants.THEME_COLOR,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: RichText(
                    //textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    text: TextSpan(
                      text: dropDownLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      divider: Container(
        height: 1,
        color: Colors.grey,
      ),
      onItemSelected: (value) {
        print(value);
        setState(() {
          StreamHelper().getStreamController().add(value);
          dropDownLabel = value;
        });

        // Action when new item is selected
      },
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.grey[300]),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
          color: Colors.white),
      onMenuButtonToggle: (isToggle) {
        print(isToggle);
      },
    );
  }
}
