import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 200, 200),
      body: SafeArea(
        child: SizedBox(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri('http://vety.cubeten.com/weblogin.aspx')),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              print('Started loading: $url');
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
          ),
        ),
      ),
    );
  }
}
