import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwebview/homepage.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  _ContactusPageState createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                if (webViewController != null) {}
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
              ))),
      backgroundColor: const Color.fromARGB(255, 201, 200, 200),
      body: SafeArea(
        child: SizedBox(
          child: InAppWebView(
            onCloseWindow: (controller) {
              log('close');
              Navigator.of(context).pop();
            },
            initialUrlRequest:
                URLRequest(url: WebUri('http://vety.cubeten.com/Contact.aspx')),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              // print('Started loading: $url');
              //    if (url == 'http://vety.cubeten.com/weblogin.aspx') {
              //   // Intercept the URL and navigate to a Flutter page instead
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const FlutterPage()),
              //   );
              //   return NavigationActionPolicy.CANCEL;
              // }
            },
            onLoadStop: (controller, url) async {
              print('Finished loading: $url');
            },
            onLoadError: (controller, url, code, message) {
              print('Error loading: $url, Error: $message');
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                print('Loading complete');
              }
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
