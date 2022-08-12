import 'package:flutter/material.dart';
import 'dart:io' show Platform, exit;

import 'package:flutter/services.dart';

class DiscannectScreen extends StatefulWidget {
  const DiscannectScreen({Key? key}) : super(key: key);

  @override
  State<DiscannectScreen> createState() => _DiscannectScreenState();
}

class _DiscannectScreenState extends State<DiscannectScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valyuta kurslari',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/gif/disconnectJson.gif',
                  width: 250,
                  height: 250,
                ),
                const Text(
                  "Iltimos internet borligiga ishonch hosil qiling",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                RaisedButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: const Text("Ilovadan chiqish", style: TextStyle(fontSize: 16),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
