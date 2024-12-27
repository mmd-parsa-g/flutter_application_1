import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/slider_app/slider.dart';
import 'package:flutter_application_1/theme_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class Usdtoirt extends StatefulWidget {
  final WebSocketChannel channel;
  const Usdtoirt({
    super.key,
    required this.channel,
  });
  @override
  State<Usdtoirt> createState() => _Usdtoirt();
}

class _Usdtoirt extends State<Usdtoirt> {
  int value = 1;
  int valuee = 0;
  bool mySwitch = false;
  static double result = 0;
  static double result1 = 0;
  Map? mapResponce;
  Map? mapResponce1;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController mycontroller = TextEditingController();
  String? stringResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.nobitex.ir/market/stats?srcCurrency=usdt&dstCurrency=rls"));
    http.Response response1;
    response1 = await http.get(Uri.parse(
        "https://api.nobitex.ir/market/stats?srcCurrency=btc&dstCurrency=rls"));
    if (response1.statusCode == 200) {
      setState(() {
        mapResponce1 = json.decode(response1.body);
      });
    }
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
        color: Color.fromARGB(255, 255, 255, 255),
        width: 2.5,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(6),
    );
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark
              ? Color.fromARGB(255, 0, 6, 32)
              : Colors.blue.shade50,
          appBar: AppBar(
              title: Text("currency converter"),
              actions: [
                AnimatedTheme(
                  curve: Curves.bounceInOut,
                  duration: Duration(milliseconds: 500),
                  data: ThemeData(
                      brightness: themeNotifier.isDark
                          ? Brightness.dark
                          : Brightness.light),
                  child: Builder(
                    builder: (BuildContext context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                themeNotifier.isDark
                                    ? themeNotifier.isDark = false
                                    : themeNotifier.isDark = true;
                              },
                              icon: Icon(themeNotifier.isDark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined)),
                        ],
                      );
                    },
                  ),
                )
              ],
              backgroundColor: themeNotifier.isDark
                  ? Colors.blue.shade900
                  : Colors.blue.shade300),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    child: Padding(
                  padding: EdgeInsets.all(15),
                )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          result = 0;
                          result1 = 0;
                          textEditingController.clear();
                        },
                        child: const Text(
                          "reset",
                        ))
                  ],
                ),
                Center(
                  child: Mydata1<int>(
                    onChanged: (b) {
                      setState(() {
                        value = b;
                      });
                    },
                    groupValue: value,
                    children: [
                      Mytext1(
                          value: 1,
                          data: value == 1
                              ? (NumberFormat.currency(symbol: "IRT ")
                                  .format(result1))
                              : (NumberFormat.currency(symbol: "IRT ")
                                  .format(result)),
                          mycolor: themeNotifier.isDark
                              ? Colors.white
                              : Colors.black)
                    ],
                  ),
                ),
                Center(
                  child: Mydata<int>(
                      groupValue: value,
                      children: [
                        Mytext(
                            value: 2,
                            data: mapResponce == null
                                ? ""
                                : value == 2
                                    ? ("USD price = ${(
                                        NumberFormat.currency(symbol: "IRT")
                                            .format(
                                          double.parse(mapResponce!['stats']
                                                  ["usdt-rls"]['latest']) *
                                              0.1,
                                        ),
                                      )}")
                                    : mapResponce1 == null
                                        ? ""
                                        : ("BTC price = ${(
                                            NumberFormat.currency(symbol: "IRT")
                                                .format(
                                              double.parse(
                                                      mapResponce1!['stats']
                                                              ["btc-rls"]
                                                          ['latest']) *
                                                  0.1,
                                            ),
                                          )}"),
                            mycolor: value == 2 ? Colors.red : Colors.blue)
                      ],
                      onChanged: (a) {
                        setState(() {
                          value = a;
                        });
                      }),
                ),
                Center(
                  child: MySlider<int>(
                    onChanged: (v) {
                      setState(() {
                        value = v;
                        textEditingController.clear();
                      });
                    },
                    groupValue: value,
                    children: [
                      SliderTextItem1(
                        color:
                            themeNotifier.isDark ? Colors.white : Colors.black,
                        value: 1,
                        text: value == 1 ? "Bitcoin" : "BTC",
                      ),
                      SliderTextItem2(
                        color:
                            themeNotifier.isDark ? Colors.white : Colors.black,
                        value: 2,
                        text: value == 2 ? "USD-Dollar" : "USD",
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                          selectionColor: Color.fromARGB(255, 255, 255, 255))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 30),
                    child: TextField(
                      maxLength: value == 2 ? 9 : 4,
                      controller: textEditingController,
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      decoration: InputDecoration(
                        label: Text(
                          "enter value",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: themeNotifier.isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        hintText: value == 2
                            ? "example 123 Dollar"
                            : "example 123 BTC",
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: themeNotifier.isDark
                              ? Colors.white54
                              : Colors.black54,
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                        prefixIconColor: const Color.fromARGB(255, 46, 46, 46),
                        filled: true,
                        fillColor: themeNotifier.isDark
                            ? Colors.blue.shade900
                            : Colors.blue.shade300,
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
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
                                mapResponce!['stats']['usdt-rls']['latest']) *
                            0.1;
                        value == 2
                            ? result =
                                double.parse(textEditingController.text) * a
                            : result = 0;
                        var b = double.parse(
                                mapResponce1!['stats']["btc-rls"]['latest']) *
                            0.1;
                        value == 1
                            ? result1 =
                                double.parse(textEditingController.text) * b
                            : result1 = 0;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: (1),
                      backgroundColor: themeNotifier.isDark
                          ? Colors.blue.shade900
                          : Colors.blue.shade300,
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      fixedSize: const Size(120, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text("compute",
                        style: TextStyle(
                            color: themeNotifier.isDark
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
