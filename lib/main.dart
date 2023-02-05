import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:valyutalar/screen/ValyutaKurslariGridFull.dart';

AppOpenAd? appOpenAd;
loadAppOpenAd(){
  AppOpenAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-2837683596775112/8208976166'
          : 'ca-app-pub-3940256099942544/5662855259',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad){
            appOpenAd=ad;
            appOpenAd!.show();
          },
          onAdFailedToLoad: (error){
            print(error);
          }
      ),
      orientation: AppOpenAd.orientationPortrait);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  loadAppOpenAd();
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
      home: const KursValyutaFull(),
    );
  }

}
