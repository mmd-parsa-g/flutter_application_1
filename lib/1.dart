import 'dart:async';
import 'dart:convert';
import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Centrifuge Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Centrifuge Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late centrifuge.Client _centrifuge;
  late centrifuge.Subscription _subscription;
  late ScrollController _controller;

  final _items = <_ChatItem>[];

  @override
  void initState() {
    const url = 'ws://localhost:8000/connection/websocket?format=protobuf';
    _centrifuge = centrifuge.createClient(url);

    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() async {
    await _centrifuge.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<Function>(
            onSelected: (f) => f(),
            itemBuilder: (context) => <PopupMenuItem<Function>>[
              PopupMenuItem(
                value: () => _connect(),
                child: const Text('Connect'),
              ),
              PopupMenuItem(
                value: () => _subscribe(),
                child: const Text('Subscribe'),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
          itemCount: _items.length,
          controller: _controller,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.subtitle),
            );
          }),
    );
  }

  void _connect() async {
    try {
      await _centrifuge.connect();
    } catch (exception) {
      _show(exception);
    }
  }

  void _subscribe() async {
    final channel = 'chat:index';
    _subscription = _centrifuge.newSubscription(channel);

    _subscription.subscribing.listen(_show);
    _subscription.subscribed.listen(_show);
    _subscription.unsubscribed.listen(_show);

    onNewItem(_ChatItem item) {
      setState(() {
        _items.add(item);
      });
      Future.delayed(const Duration(milliseconds: 125), () => _controller.jumpTo(64.0 + _controller.offset));
    }

    _subscription.join.listen((event) {
      final user = event.user;
      final client = event.client;

      final item = _ChatItem(title: 'User $user joined channel $channel', subtitle: '(client ID $client)');
      onNewItem(item);
    });

    _subscription.leave.listen((event) {
      final user = event.user;
      final client = event.client;
      final item = _ChatItem(title: 'User $user left channel $channel', subtitle: '(client ID $client)');
      onNewItem(item);
    });

    _subscription.publication.listen((event) {
      final String message = json.decode(utf8.decode(event.data))['input'];

      final item = _ChatItem(title: message, subtitle: 'User: user');
      onNewItem(item);
    });

    await _subscription.subscribe();
  }

  void _show(dynamic error) {
    showDialog<AlertDialog>(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          error.toString(),
        ),
      ),
    );
  }
}

class _ChatItem {
  _ChatItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}