import 'package:flutter/material.dart';
import 'package:flutter_application_1/mod/bloc.dart';

class MySwitch extends StatelessWidget {
  const MySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    BoolBloc swt = BoolBloc();
    return StreamBuilder<bool>(
        stream: swt.streams,
        builder: (context, snapshot) {
          return Switch(
              value: snapshot.data ?? false,
              onChanged: (val) => swt.setValue(val));
        });
  }
}

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    BoolBloc swt = BoolBloc();
    return StreamBuilder<bool>(
        stream: swt.streams,
        builder: (context, snapshot) {
          return Checkbox(
              value: snapshot.data ?? false,
              onChanged: (val) => swt.setValue(val!));
        });
  }
}


class Mydropdownbutton extends StatelessWidget {
  final List<DropdownMenuItem<int>> items;
  const Mydropdownbutton(int defvalue, {super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    IntBloc drp = IntBloc();
    return StreamBuilder<int>(
      stream: drp.streams,
      builder: (context, snapshot) {
        return DropdownButton<int>(
          value: snapshot.data ?? 1,
          items: items,
          onChanged: (val) => drp.setValue(val!),
        );
      },
    );
  }
}
