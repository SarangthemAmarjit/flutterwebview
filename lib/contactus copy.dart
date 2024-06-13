import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwebview/homepage.dart';

class IlpPage extends StatefulWidget {
  const IlpPage({super.key});

  @override
  _IlpPageState createState() => _IlpPageState();
}

class _IlpPageState extends State<IlpPage> {
  InAppWebViewController? webViewController;
  bool isLoading = true; // Variable to track loading status

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 200, 200),
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              preventGestureDelay: true,
              onCloseWindow: (controller) {
                log('close');
                Navigator.of(context).pop();
              },
              initialUrlRequest: URLRequest(
                url: WebUri(
                  forceToStringRawValue: true,
                  'https://manipurilponline.mn.gov.in/forms/temporary.aspx',
                ),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true; // Show progress indicator
                });
                print('Started loading: $url');
              },
              onLoadStop: (controller, url) async {
                print('Finished loading: $url');
                // Inject JavaScript to remove the green footer and add padding at the end of the content
                await controller.evaluateJavascript(source: """
                  document.getElementById('footer').style.display='none';
                  document.getElementsByClassName('navbar-wrapper')[0].style.display = 'none';

                  var style = document.createElement('style');
                  style.innerHTML = `
                    body, * {
                      font-family: 'Roboto',sans-serif;
                      font-size: 16px; /* Adjust the font size as needed */
                    }
                  `;
                  document.head.appendChild(style);

                  var paddingDiv = document.createElement('div');
                  paddingDiv.style.height = '50px'; // Adjust the height as needed
                  document.body.appendChild(paddingDiv);
                     // Wait for the page to finish loading before modifying font style
   console.log(document.documentElement.outerHTML);
                """).whenComplete(() {
                  setState(() {
                    isLoading = false; // Hide progress indicator
                  });
                });
              },
              onLoadError: (controller, url, code, message) {
                print('Error loading: $url, Error: $message');
                setState(() {
                  isLoading = false; // Hide progress indicator
                });
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
                  javaScriptEnabled: true,
                  disableContextMenu: true, // Disables the context menu
                ),
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: true,
                  displayZoomControls: false, // Hides zoom controls
                  builtInZoomControls: false, // Disables built-in zoom controls
                  verticalScrollbarThumbColor:
                      Colors.transparent, // Hides vertical scrollbar
                  horizontalScrollbarThumbColor:
                      Colors.transparent, // Hides horizontal scrollbar
                ),
              ),
            ),
            if (isLoading)
              Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
