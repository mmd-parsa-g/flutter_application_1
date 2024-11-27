import 'package:flutter/material.dart';

class MyAppBar extends AppBar {

  MyAppBar({super.key})
      : super(
          title: const Text("practice" ,),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            )
          ]);
}
