import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:valyutalar/SplashScreen.dart';
import 'package:valyutalar/screen/DisconnectScreen.dart';
import 'package:valyutalar/screen/ValyutaKurslariAddSerach.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:valyutalar/screen/ValyutaKurslariGrid.dart';
import 'package:valyutalar/screen/ValyutaKurslariGridFull.dart';

// void main() async{
//   var listener = InternetConnectionChecker().onStatusChange.listen((status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//         runApp(const MyApp());
//         print('Internet connection.');
//         break;
//       case InternetConnectionStatus.disconnected:
//         runApp(const DiscannectScreen());
//         print('Internet disconnected.');
//         break;
//     }
//   });
//   await Future.delayed(Duration(seconds: 30));
//   await listener.cancel();
// }


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
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
      home: const SplashScreen(),
    );
  }
  // Widget build(BuildContext context) {
  //   return StreamProvider<InternetConnectionStatus>(
  //     initialData: InternetConnectionStatus.connected,
  //     create: (_){
  //       return InternetConnectionChecker().onStatusChange;
  //     },
  //     child: MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Valyuta kurslari',
  //     theme: ThemeData(
  //       primarySwatch: Colors.green,
  //     ),
  //     home: Visibility(
  //       visible: Provider.of<InternetConnectionStatus>(context) == InternetConnectionStatus.disconnected ?
  //       DiscannectScreen() : ValyutaKursAddSerach(),
  //       child: null,
  //     ),
  //
  //     )
  //   );
  // }

}
