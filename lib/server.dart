import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final ip = InternetAddress.anyIPv4;
  final server = await ServerSocket.bind(ip, 3000);
  print("Server is running on : ${ip.address} : 3000");
  server.listen((Socket event) {
    handleConnection(event);
  });
}

List<Socket> clients = [];

void handleConnection(Socket client) {
  client.listen((Uint8List data) {
    final massage = String.fromCharCodes(data);

    for (final c in clients) {
      c.write('server : you join in $massage');
    }
    clients.add(client);
    client.write("Server : you are log in $massage");
  }, onError: (error) {
    print("error");
    client.close();
  }, onDone: () {
    print("massage1");
    client.close();
  });
}
