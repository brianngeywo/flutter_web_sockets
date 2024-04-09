import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter_web_sockets/rand.dart';


class WebSocketsProviderService {
  late Realtime _realtimeInstance;
  late RealtimeChannel _channel;

  RealtimeChannel get channel => _channel;

  WebSocketsProviderService() {
    _initializeAbly();
  }

  Future<void> _initializeAbly() async {
    // Connect to Ably with your API key
    _realtimeInstance = Realtime(key: 'api_key');

    // Create a channel called 'get-started'
    _channel = _realtimeInstance.channels.get('get-started');

    // Listen for connection state changes
    _realtimeInstance.connection.on(ConnectionEvent.connected).listen(_handleConnected);
    _realtimeInstance.connection.on(ConnectionEvent.closed).listen(_handleClosed);
  }

  void _handleConnected(ConnectionStateChange stateChange) {
    if (stateChange.current == ConnectionState.connected) {
      print('Connected to Ably!');

      // Subscribe to messages with the name 'first'
      _channel.subscribe().listen(_handleMessage);
    }
  }

  void  _handleMessage(Message message) {
    print('Received message: ${message.data}');
    messagesController.message.value = message.data.toString();
  }

  void _handleClosed(ConnectionStateChange stateChange) {
    if (stateChange.current == ConnectionState.closed) {
      print('Closed connection to Ably.');
    }
  }

  Future<void> sendMessage(String message) async {
    // Publish a message with the name 'first'
    await _channel.publish(name: 'first', data: message);
  }

  void closeConnection() {
    _realtimeInstance.connection.close();
  }
}