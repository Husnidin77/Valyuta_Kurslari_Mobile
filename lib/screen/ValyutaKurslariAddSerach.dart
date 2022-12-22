import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valyutalar/screen/Conversiya.dart';
import 'package:valyutalar/screen/Url.dart';
import 'package:http/http.dart' as http;
import '../modul/KursJson.dart';

class ValyutaKursAddSerach extends StatefulWidget {
  const ValyutaKursAddSerach({Key? key}) : super(key: key);

  @override
  State<ValyutaKursAddSerach> createState() => _ValyutaKursAddSerachState();
}

class _ValyutaKursAddSerachState extends State<ValyutaKursAddSerach> {
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
      final response = await http.get(url, headers: {
        "Access-Control_Allow_Origin": "*",
        "Accept": "application/json",
        "content-type": "application/json"
      });
      if (response.statusCode == 200) {
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("VALYUTALAR KURSLARI"),
        ),
      ),
      body: Container(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            color: Colors.white,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Colors.green.shade100,
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
                  child: _serach.length != 0 || controller.text.isNotEmpty
                      ? ListView.builder(
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
                              child: Container(
                                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
                                // color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: _w / 60),
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets.all(10),
                                                  child: CircleAvatar(
                                                    child: Text(b.ccy),
                                                  )),
                                              Container(
                                                padding: EdgeInsets.only(top: 14),
                                                child: Text(
                                                  b.ccyNmUz,
                                                  style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(right: 15),
                                                child: Text(
                                                  b.date,
                                                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(right: 15),
                                                child: Text(
                                                  b.rate,
                                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 15),
                                                    child: Column(
                                                      children: [
                                                        if (diff > 0.0) ...[
                                                          Text(
                                                            b.diff,
                                                            style: const TextStyle(color: Colors.green),
                                                          )
                                                        ] else ...[
                                                          Text(
                                                            b.diff,
                                                            style: const TextStyle(color: Colors.red),
                                                          )
                                                        ],
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Column(
                                                      children: [
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
                                        ],
                                      ),
                                    ),
                                    // Text(a.ccy),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: _list.length,
                          itemBuilder: (context, i) {
                            final a = _list[i];
                            double diff = double.parse(a.diff);
                            String flag = a.ccy;
                            String flags = flag.substring(0, 2).toLowerCase();
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Conversiya(a.code, a.rate, a.ccy, a.ccyNmUz),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
                                // color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: _w / 80),
                                      height: 75,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets.all(10),
                                                  child: CircleAvatar(
                                                    child: Text(a.ccy),
                                                  )
                                                  // child: new SvgPicture.asset('assets/flags/${flags}.svg', width: 26, height: 26),
                                                  ),
                                              Container(
                                                padding: const EdgeInsets.only(top: 14),
                                                child: Text(
                                                  a.ccyNmUz,
                                                  style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(right: 15),
                                                child: Text(
                                                  a.date,
                                                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(right: 15),
                                                child: Text(
                                                  a.rate,
                                                  style: const TextStyle(color: Colors.black, fontSize: 20),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 15),
                                                    child: Column(
                                                      children: [
                                                        if (diff > 0.0) ...[
                                                          Text(
                                                            a.diff,
                                                            style: const TextStyle(color: Colors.green),
                                                          )
                                                        ] else ...[
                                                          Text(
                                                            a.diff,
                                                            style: const TextStyle(color: Colors.red),
                                                          )
                                                        ],
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Column(
                                                      children: [
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
                                        ],
                                      ),
                                    ),
                                    // Text(a.ccy),
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Valyuta kurslari', textAlign: TextAlign.center),
            content: const Text("Kurs ma'lumotlari www.cbu.uz saytidan olinmoqda. \n\n\nmatyaqubovhusnidin@gmail.com"),
            actions: <Widget>[
              // TextButton(
              //   onPressed: () => Navigator.pop(context, 'Cancel'),
              //   child: const Text(''),
              // ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        tooltip: 'Info',
        child: const Icon(
          Icons.info,
          size: 30,
        ),
      ),
    );
  }
}
