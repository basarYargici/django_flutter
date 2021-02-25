import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';

import '../add_synonym_screen.dart';
import '../add_translate_screen.dart';

Widget buildBoomFAB(BuildContext context) {
  return BoomMenu(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 25.0),
    scrollVisible: true,
    overlayColor: Colors.black,
    overlayOpacity: 0.8,
    children: [
      MenuItem(
        child: Icon(Icons.add),
        title: 'Add synonym',
        titleColor: Colors.white,
        subtitle: 'You Can Add new Synonym',
        subTitleColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSynonymScreen()));
        },
      ),
      MenuItem(
        child: Icon(Icons.brush, color: Colors.black),
        title: 'Add Translate',
        titleColor: Colors.white,
        subtitle: 'You Can Add new Translations',
        subTitleColor: Colors.white,
        backgroundColor: Colors.green,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTranslateScreen()));
        },
      ),
    ],
  );
}
