import 'package:flutter/material.dart';



class MyDrawer extends Drawer {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      //backgroundColor: const Color.fromARGB(255, 70, 70, 70),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          const SizedBox(
            height: 62,
            child: DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 138, 25, 25),
                border: Border.fromBorderSide(
                  BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 2.5,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 0),
                child: Text(
                  ("choose currency"),
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
