import 'package:flutter/material.dart';
import 'package:flutter_application_1/main/main_app.dart';

import 'package:flutter_application_1/theme_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(
    const Myapp(),
  );
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool mySwitch = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            themeAnimationDuration: Duration(milliseconds: 300),
            theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: const Color.fromARGB(255, 0, 17, 255),
                brightness:
                    themeNotifier.isDark ? Brightness.dark : Brightness.light),
            debugShowCheckedModeBanner: false,
            home: Usdtoirt(
                channel: WebSocketChannel.connect(
                    Uri.parse("wss://wss.nobitex.ir/connection/websocket"))),
            routes: {
              'Tether': (context) => Usdtoirt(
                  channel: WebSocketChannel.connect(
                      Uri.parse("wss://wss.nobitex.ir/connection/websocket"))),
            },
            initialRoute: 'Tether',
          );
        },
      ),
    );
  }
}
