import 'package:flutter/material.dart';
import 'package:flutter_application_1/mod/myprovider.dart';
import 'package:flutter_application_1/mod/widget.dart';
import 'package:provider/provider.dart';


class Stateful extends StatefulWidget {
  const Stateful({super.key});
  @override
  State<Stateful> createState() => _Stateful();
}

class _Stateful extends State<Stateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 204, 255),
        title: const Text("state manegment"),
        leading: Switch (
          value: context.watch<Myprovider>().theme == Themedata.dark,
          onChanged : (val)=> context.read<Myprovider>().setTheme(val ? Themedata.dark : Themedata.light)
        )
            
      ),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              MySwitch(),
              MyCheckbox(),
              Mydropdownbutton(1, items: [
                DropdownMenuItem(child: Text("salam"), value: 1),
                DropdownMenuItem(child: Text("hi"), value: 2),
                DropdownMenuItem(child: Text("hallo"), value: 3),
              ]),
              Mydropdownbutton(2, items: [
                DropdownMenuItem(child: Text("kir"), value: 1),
                DropdownMenuItem(child: Text("kos"), value: 2),
                DropdownMenuItem(child: Text("kon"), value: 3)
              ])
            ],
          ),
        ),
      ),
    );
  }
}
