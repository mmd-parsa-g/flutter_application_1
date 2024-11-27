import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Btc extends StatefulWidget {
  const Btc({super.key});
  @override
  State<Btc> createState() => _Btc();
}

class _Btc extends State<Btc> {
  final TextEditingController textEditingController = TextEditingController();
  static double result = 0.0;
  Map? mapResponce;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.nobitex.ir/market/stats?srcCurrency=btc&dstCurrency=rls"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponce = json.decode(response.body);
      });
    }
  }

  void mytimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchData();
    });
  }

  @override
  void initState() {
    mytimer();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.5,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(6),
    );

    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: const Color.fromARGB(255, 70, 70, 70),
        
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            mapResponce == null
                ? Container()
                : Text(
                    ("Btc price = ${(
                      NumberFormat.currency(symbol: "IRT").format(
                        double.parse(
                                mapResponce!['stats']["btc-rls"]['latest']) *
                            0.1,
                      ),
                    )}"),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
            Text(
              (NumberFormat.currency(symbol: "IRT ").format(result)),
              style: const TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                      selectionColor: Color.fromARGB(255, 255, 255, 255))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 30),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  decoration: InputDecoration(
                      label: const Text(
                        "enter value",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      hintText: "example 123 Btc",
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 97, 21, 21),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                      prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 170, 170, 170),
                      focusedBorder: border,
                      enabledBorder: border),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    var a = double.parse(
                            mapResponce!['stats']['btc-rls']['latest']) *
                        0.1;

                    result = double.parse(textEditingController.text) * a;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 2.5,
                    style: BorderStyle.solid,
                  ),
                  elevation: (15),
                  backgroundColor: const Color.fromARGB(255, 170, 170, 170),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  fixedSize: const Size(120, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("compute",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ]),
        ),
        drawer: const MyDrawer()
      ),
    );
  }
}
