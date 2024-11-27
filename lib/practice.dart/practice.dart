import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/practice.dart/appbar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Practice());
}

class Practice extends StatefulWidget {
  const Practice({super.key});
 
  @override
  State<Practice> createState() => _Practice();
}

class _Practice extends State<Practice> {
  static Map? fetchdataa;

  Future fetchdata() async {
    var url = Uri.parse(
        "https://api.nobitex.ir/market/stats?srcCurrency=not&dstCurrency=rls");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        fetchdataa = json.decode(response.body);
      });
    }
  }


  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "practice",
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              fetchdataa == null
                  ? Container()
                  : Text(
                      "${fetchdataa?["global"]["binance"]["btc"]}",
                      style: const TextStyle(fontSize: 25),
                    ),
              FloatingActionButton(
                  onPressed: () {
                    
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.refresh)),
            ],
          ),
        ),
      ),
    );
  }
}

