import 'package:flutter/material.dart';

class DiscannectScreen extends StatefulWidget {
  const DiscannectScreen({Key? key}) : super(key: key);

  @override
  State<DiscannectScreen> createState() => _DiscannectScreenState();
}

class _DiscannectScreenState extends State<DiscannectScreen> {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Valyuta kurslari',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/gif/disconnectJson.gif',
                  width: 50,
                  height: 50,
                )
              ],
            ),
          ),
        ),
    ),
      );
  }
}
