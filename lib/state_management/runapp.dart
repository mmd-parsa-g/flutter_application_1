import 'package:flutter/material.dart';
import 'package:flutter_application_1/mod/myprovider.dart';
import 'package:flutter_application_1/state_management/state_management.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Myprovider())],
      
    ),
  );
}

class Runapp extends StatelessWidget {
  const Runapp(WebSocketPage webSocketPage, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      theme: ThemeData(
          brightness: context.watch<Myprovider>().theme == Themedata.dark
              ? Brightness.dark
              : Brightness.light,
          primaryColor: Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: const Stateful(),
    );
  }
}

class WebSocketPage {
}
