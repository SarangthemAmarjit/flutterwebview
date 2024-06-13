import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        minimum: const EdgeInsets.symmetric(vertical: 0),
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
                // Load the font file as bytes

                setState(() {
                  isLoading = true; // Show progress indicator
                });
                print('Started loading: $url');
              },
              onLoadStop: (controller, url) async {
                print('Finished loading: $url');
                ByteData fontData =
                    await rootBundle.load('assets/fonts/KulimPark-Regular.ttf');
                Uint8List fontBytes = fontData.buffer.asUint8List();
                String base64Font = base64.encode(fontBytes);
                await controller.injectCSSCode(source: '''

                          @font-face {
                              font-family: 'KulimPark-Regular';
                              src: url(data:font/ttf;base64,$base64Font) format('truetype');
                            }
                                                                      .container {
                                                  font-family: "KulimPark-Regular"; 
                                                  font-size: 14px; 
                                            
                                              }
                                              .h1, h1 {
                                display: none;
                        }
                        .h2, h2 {
                            padding-bottom: 30px;
                            font-weight: bold; 
                              margin-top: -20px;
  
                        }


                                                  td, th {
                              padding-right: 7px;
                          }



                                .navbar-fixed-top {
                                    display: none;   
                                }
                                                .navbar-default {
                          display: none;
                      }
                                          
                                                                                        
          ''');
                // Inject JavaScript to remove the green footer and add padding at the end of the content
                await controller.evaluateJavascript(source: """
                  document.getElementById('footer').style.display='none';

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
              onLoadError: (controllerr, url, code, message) async {
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
