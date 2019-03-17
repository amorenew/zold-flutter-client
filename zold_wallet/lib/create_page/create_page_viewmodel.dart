import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import './create_page.dart';
import '../wallet.dart';
import '../wts_log.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

typedef Future<WtsLog> WaitingCallback();
abstract class CreatePageViewModel extends State<CreatePage> {
  Wallet wallet = Wallet.wallet;
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  GlobalKey globalKey = new GlobalKey();
  String qrString = "";
  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  void captureAndSharePng() async {
    Map<String, String> values =Map();
    values["bnf"] = bnfController.text;
    values["amount"] = amountController.text;
    values["details"] = messageController.text;
    debugPrint(json.encode(values));
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      // @todo #18 add share methods to native code.
      final channel = const MethodChannel('channel:me.ammar.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }
}