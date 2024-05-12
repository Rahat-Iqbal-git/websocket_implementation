import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class SocketDataView extends StatefulWidget {
  const SocketDataView({super.key});

  @override
  State<SocketDataView> createState() => _SocketDataViewState();
}

class _SocketDataViewState extends State<SocketDataView> {
  @override
  void initState() {
    super.initState();
    socketListener();
  }

  final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@trade');
  var streamData = "";

  socketListener() {
    channel.stream.listen((event) {
      log(event.toString());
      setState(() {
        streamData = event.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Websocket Data",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            streamData = "";
          });
        },
        tooltip: 'Clear',
        child: const Text("Clear"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(streamData),
          ],
        ),
      ),
    );
  }
}
