import './create_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreatePageView extends CreatePageViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create QR"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text("bnf: "),
                      ),
                      Flexible(
                        child: TextField(
                          controller: bnfController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'eg. ammaratef45'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text("Amount: "),
                      ),
                      Flexible(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'eg. 1.2'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text("Details: "),
                      ),
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'eg. for selling me the book'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        version: 2,
                        data: qrString,
                        onError: (ex) {
                          debugPrint("[QR] ERROR - $ex");
                        },
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureAndSharePng,
        tooltip: 'Share QR',
        child: Icon(Icons.share),
        elevation: 2.0,
      ),
    );
  }

}