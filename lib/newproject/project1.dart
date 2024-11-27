import 'package:flutter/material.dart';
import 'package:flutter_application_1/mod/myprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Myprovider())],
      child: const Myproject(),
    ),
  );
}

class Myproject extends StatefulWidget {
  const Myproject({super.key});

  @override
  State<Myproject> createState() => _MyprojectState();
}

class _MyprojectState extends State<Myproject> {
  int? click;
  int? clickk;
  int select = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: context.watch<Myprovider>().theme == Themedata.dark
            ? Brightness.dark
            : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("curreny cunverter"),
          backgroundColor: const Color.fromARGB(255, 141, 35, 28),
          leading: Switch(
            value: context.watch<Myprovider>().theme == Themedata.dark,
            onChanged: (val) => context
                .read<Myprovider>()
                .setTheme(val ? Themedata.dark : Themedata.light),
          ),
        ),
        body: Center(
          child: Container(
            color: const Color.fromARGB(150, 177, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        click = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon((click == select) ? Icons.add_home_rounded : Icons.album_sharp),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                        () {},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon((click == true)
                          ? Icons.account_balance_rounded
                          : Icons.abc),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
