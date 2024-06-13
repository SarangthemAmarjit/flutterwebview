import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwebview/contactus%20copy.dart';
import 'package:flutterwebview/contactus.dart';
import 'package:flutterwebview/dashboard.dart';
import 'package:flutterwebview/webpage.dart';

class FlutterPage extends StatelessWidget {
  const FlutterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'WELCOME TO HOMEPAGE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                      );
                    },
                    child: const Card(
                      elevation: 10,
                      child: SizedBox(
                        width: 130,
                        height: 100,
                        child: Center(child: Text('DASHBOARD')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Card(
                    elevation: 10,
                    child: SizedBox(
                      width: 130,
                      height: 100,
                      child: Center(child: Text('TRACK VEHICLE')),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactusPage()),
                      );
                    },
                    child: const Card(
                      elevation: 10,
                      child: SizedBox(
                        width: 130,
                        height: 100,
                        child: Center(child: Text('CONTACT US')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebViewPage()),
                      );
                    },
                    child: const Card(
                      elevation: 10,
                      child: SizedBox(
                        width: 130,
                        height: 100,
                        child: Center(child: Text('LOGIN')),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IlpPage()),
                );
              },
              child: const Card(
                elevation: 10,
                child: SizedBox(
                  width: 130,
                  height: 100,
                  child: Center(child: Text('ILP REGISTRATION')),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
