import 'package:flutter/material.dart';
import 'package:valyutalar/screen/DisconnectScreen.dart';
import 'package:valyutalar/screen/ValyutaKurslariAddSerach.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async{
  var listener = InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        runApp(const MyApp());
        print('Internet connection.');
        break;
      case InternetConnectionStatus.disconnected:
        runApp(const DiscannectScreen());
        print('Internet disconnected.');
        break;
    }
  });
  await Future.delayed(Duration(seconds: 30));
  await listener.cancel();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valyuta kurslari',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ValyutaKursAddSerach(),
    );
  }
}
