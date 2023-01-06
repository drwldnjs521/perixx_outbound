import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

List<String> menus = ['all', 'processing', 'scanned', 'shipped'];

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [];
  for (var menu in menus) {
    menuItems.addAll(
      [
        DropdownMenuItem(
          value: menu,
          child: Text(
            menu,
            style: GoogleFonts.notoSans(
              fontSize: SizeConfig.safeHorizontal * 0.05,
              color: Colors.blueGrey,
            ),
          ),
        ),
        if (menu != menus.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(
              color: Color.fromARGB(107, 83, 80, 80),
            ),
          ),
      ],
    );
  }
  return menuItems;
}

List<double> get customsItemsHeight {
  List<double> itemsHeights = [];
  for (var i = 0; i < (menus.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(SizeConfig.safeVertical * 0.05);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(SizeConfig.safeVertical * 0.015);
    }
  }
  return itemsHeights;
}

final List locale = [
  {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
  {'name': 'DEUTSCH', 'locale': const Locale('ge', 'GE')},
];
