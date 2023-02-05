import 'package:flutter/material.dart';

import '../modul/KursJson.dart';
import '../routes/CustomBannerAd.dart';

class Conversiya extends StatelessWidget {
  final String code;
  final String rate;
  final String ccy;
  final String ccyNmUz;

  Conversiya(String this.code, this.rate, this.ccy, this.ccyNmUz, {Key? key})
      : super(key: key);

  final List<KursJson> _oneList = [];

  double get ccyNum => double.parse(rate);
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    String flag = ccy;
    String flags = flag.substring(0, 2).toLowerCase();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBannerAd(),
      appBar: AppBar(
        title: const Text("Valyuta hisoblash"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        ccy,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    child: TextFormField(
                      controller: _controllerA,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        hintText: "Raqam kiriting...",
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String? val) {
                        _colc();
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage:
                            ExactAssetImage('assets/img/flags/${flags}.png'),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // padding: EdgeInsets.only(top: 3),
                      child: const Text(
                        "UZB",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    child: AbsorbPointer(
                      child: TextFormField(
                        enabled: false,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            hintText: rate,
                        ),

                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: const CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/img/flags/uz.png'),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        "Natija: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _controllerB,
                        enabled: false,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          hintText: "",
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBannerAd(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _colc(){
    if(_controllerA.text.trim().isNotEmpty){
      final count = double.parse(_controllerA.text);
      _controllerB.text = (count * ccyNum).toString();
    }
  }
}
