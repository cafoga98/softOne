import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum currentPlatform{isIos, isAndroid}

class WidgetAppBar {
  currentPlatform? platformType;

  WidgetAppBar({@required this.platformType});

  AppBar appBarIos(BuildContext context){
    TextEditingController editingController = TextEditingController();

    AppBar widget = AppBar(
      backgroundColor: const Color(0xFFCB172F),
      automaticallyImplyLeading: false,
      title: TextField(
        style: const TextStyle(color: Colors.white, decorationColor: Colors.white),
        decoration: const InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
        cursorColor: Colors.white,
        controller: editingController,
      ),
      actions: [
        IconButton(
            onPressed: (){
              FocusScope.of(context).unfocus();
              editingController.clear();
            },
            icon: const Icon(Icons.search))
      ],
    );

    return widget;
  }

}