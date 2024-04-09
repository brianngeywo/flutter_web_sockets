import 'package:flutter_web_sockets/getx_controller.dart';
import 'package:flutter_web_sockets/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

final webSocketService = WebSocketsProviderService();
final messagesController = Get.find<GetXMessageController>();