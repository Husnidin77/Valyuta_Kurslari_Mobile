import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:indexed/indexed.dart';
import 'package:valyutalar/screen/ValyutaKurslariAddSerach.dart';
import '../AppOpenAdManager.dart';
import '../modul/KursJson.dart';
import 'Conversiya.dart';
import 'Url.dart';

class KursValyutaFull extends StatefulWidget {
  const KursValyutaFull({Key? key}) : super(key: key);

  @override
  State<KursValyutaFull> createState() => _KursValyutaFullState();
}

class _KursValyutaFullState extends State<KursValyutaFull> with WidgetsBindingObserver {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appOpenAdManager.loadAd();
    WidgetsBinding.instance.addObserver(this);

    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
    }
  }

  final List<KursJson> _list = [];
  final List<KursJson> _serach = [];

  var _postJson = [];
  var loading = false;

  void fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final url = Uri.parse(urlAll);
    try {
      final response =
          await http.get(url, headers: {"Access-Control_Allow_Origin": "*", "Accept": "application/json", "content-type": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);

        setState(() {
          for (var i in data) {
            _list.add(KursJson.formJson(i));
            loading = false;
          }
        });
      }
    } catch (err) {}
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _serach.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((f) {
      if (f.ccy.toUpperCase().contains(text) ||
          f.ccyNmUz.toUpperCase().contains(text) ||
          f.ccyNmRu.toUpperCase().contains(text) ||
          f.ccyNmUzc.toUpperCase().contains(text) ||
          f.code.toUpperCase().contains(text) ||
          f.date.toUpperCase().contains(text) ||
          f.date.toUpperCase().contains(text)) _serach.add(f);
    });
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ValyutaKursAddSerach(),
                  ),
                );
              },
              icon: const Icon(Icons.list))
        ],
        title: const Center(
          child: Text("VALYUTALAR KURSLARI"),
        ),
      ),
      body: Container(
        color: Colors.white24,
        child: Column(
          children: [
            Container(
              color: Colors.green.shade100,
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: (value) {
                      controller.value = TextEditingValue(text: value.toUpperCase(), selection: controller.selection);
                      onSearch(value);
                    },
                    decoration: const InputDecoration(hintText: "Qidiruv", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch("");
                    },
                    icon: const Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: (_serach.length != 0) || controller.text.isNotEmpty
                        ? Container(
                            color: Colors.green.shade100,
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250, childAspectRatio: 3 / 2, crossAxisSpacing: 5, mainAxisSpacing: 10),
                                itemCount: _serach.length,
                                itemBuilder: (context, i) {
                                  final b = _serach[i];
                                  double diff = double.parse(b.diff);
                                  String flagb = b.ccy;
                                  String flags = flagb.substring(0, 2).toLowerCase();
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Conversiya(b.code, b.rate, b.ccy, b.ccyNmUz),
                                        ),
                                      );
                                    },
                                    child: Indexer(
                                      children: <Widget>[
                                        Indexed(
                                          index: 1,
                                          child: Positioned(
                                            top: 20,
                                            left: 5,
                                            right: 10,
                                            child: Container(
                                              height: 100,
                                              width: 170,
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: const EdgeInsets.only(top: 5, right: 5),
                                                        child: Text(
                                                          b.rate + " so'm",
                                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 20),
                                                          child: Text(
                                                            b.ccyNmUz,
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 2),
                                                          child: Text(
                                                            "(" + b.code + ")",
                                                            style: const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 5),
                                                          child: Text(
                                                            b.date,
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                          )),
                                                      Container(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: Column(
                                                          children: <Widget>[
                                                            if (diff > 0.0) ...[
                                                              Text(
                                                                b.diff,
                                                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                                              )
                                                            ] else ...[
                                                              Text(
                                                                b.diff,
                                                                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                                                              )
                                                            ],
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(right: 5),
                                                        child: Column(
                                                          children: <Widget>[
                                                            if (diff > 0.0) ...[
                                                              Image.asset(
                                                                'assets/img/yashil.png',
                                                                width: 26,
                                                                height: 26,
                                                              )
                                                            ] else ...[
                                                              Image.asset('assets/img/qizil.png', width: 26, height: 26),
                                                            ],
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Indexed(
                                          index: 2,
                                          //last at widget tree, but middle in order
                                          child: Positioned(
                                            top: 2,
                                            left: 5,
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 15),
                                              height: 50, width: 50,
                                              // color: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black12,
                                                radius: 60.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white24,
                                                  backgroundImage: AssetImage('assets/img/flags/$flags.png'), //Text
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            color: Colors.green.shade100,
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250, childAspectRatio: 3 / 2, crossAxisSpacing: 5, mainAxisSpacing: 10),
                                itemCount: _list.length,
                                itemBuilder: (context, i) {
                                  final b = _list[i];
                                  double diff = double.parse(b.diff);
                                  String flagb = b.ccy;
                                  String flags = flagb.substring(0, 2).toLowerCase();
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Conversiya(b.code, b.rate, b.ccy, b.ccyNmUz),
                                        ),
                                      );
                                    },
                                    child: Indexer(
                                      children: <Widget>[
                                        Indexed(
                                          index: 1,
                                          child: Positioned(
                                            top: 20,
                                            left: 5,
                                            right: 10,
                                            child: Container(
                                              height: 100,
                                              width: 170,
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: const EdgeInsets.only(top: 5, right: 5),
                                                        child: Text(
                                                          b.rate + " so'm",
                                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 20),
                                                          child: Text(
                                                            b.ccyNmUz,
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 2),
                                                          child: Text(
                                                            "(" + b.code + ")",
                                                            style: const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: const EdgeInsets.only(left: 5, top: 5),
                                                          child: Text(
                                                            b.date,
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                          )),
                                                      Container(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: Column(
                                                          children: <Widget>[
                                                            if (diff > 0.0) ...[
                                                              Text(
                                                                b.diff,
                                                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                                              )
                                                            ] else ...[
                                                              Text(
                                                                b.diff,
                                                                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                                                              )
                                                            ],
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(right: 5),
                                                        child: Column(
                                                          children: <Widget>[
                                                            if (diff > 0.0) ...[
                                                              Image.asset(
                                                                'assets/img/yashil.png',
                                                                width: 26,
                                                                height: 26,
                                                              )
                                                            ] else ...[
                                                              Image.asset('assets/img/qizil.png', width: 26, height: 26),
                                                            ],
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Indexed(
                                          index: 2,
                                          //last at widget tree, but middle in order
                                          child: Positioned(
                                            top: 2,
                                            left: 5,
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 15),
                                              height: 50, width: 50,
                                              // color: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black26,
                                                radius: 60.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white24,
                                                  backgroundImage: AssetImage('assets/img/flags/$flags.png'), //Text
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
