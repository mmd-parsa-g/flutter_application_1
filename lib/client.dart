import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketExample extends StatefulWidget {
  const WebSocketExample({super.key});

  @override
  WebSocketExampleState createState() => WebSocketExampleState();
}

class WebSocketExampleState extends State<WebSocketExample> {
  late WebSocketChannel _channel;
  String _message = 'Waiting for data...';

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  // Method to connect to WebSocket
  void _connectToWebSocket() {
    // Replace this URL with the actual Nobitex WebSocket URL
    final String url =
        'wss://ws.sarrafex.com/connect'; // Example WebSocket URL

    // Connect to the WebSocket server
    _channel = WebSocketChannel.connect(
      Uri.parse(url),
    );

    // Listen to the WebSocket stream and get the messages
    _channel.stream.listen((message) {
      setState(() {
        _message = message; // Update the message on new data
      });
    }, onError: (error) {
      setState(() {
        _message = 'Error: $error';
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('WebSocket message:'),
            Text(
              _message,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WebSocketExample(),
  ));
}
