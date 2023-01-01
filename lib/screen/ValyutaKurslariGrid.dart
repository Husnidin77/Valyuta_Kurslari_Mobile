import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:indexed/indexed.dart';
import 'package:http/http.dart' as http;

import '../modul/KursJson.dart';
import 'Url.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
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





  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('VIEW ANIMATING GRIDVIEW'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GridView1()),
            );
          },
        ),
      ),
    );
  }
}

class GridView1 extends StatelessWidget {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(title: Text("VALYUTALAR KURSLARI"), centerTitle: true, brightness: Brightness.dark),
      body:

      AnimationLimiter(
        child: GridView.count(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(5),
          crossAxisCount: columnCount,
          children: [
            AnimationConfiguration.staggeredGrid(
              position: 1,
              duration: Duration(milliseconds: 500),
              columnCount: columnCount,
              child: ScaleAnimation(
                duration: Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Indexer(
                    children: <Widget>[
                      Indexed(
                        index: 1, //more the index, upper the order
                        child: Positioned(
                          top: 20, left: 5,
                          child: Container(
                            height: 100, width: 150,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(left: 10, top: 35),
                                        child: Text("Dollor")
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: Text("Sana")
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(top: 10, right: 10),
                                        child: Text("img")
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 10, right: 10),
                                        child: Text("1111.1"),),
                                    Container(
                                        padding: const EdgeInsets.only(top: 10, right: 10),
                                        child: Text("-15")
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Indexed(
                        index: 2, //last at widget tree, but middle in order
                        child: Positioned(
                          top: 2, left: 5,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 50, width: 50,
                            // color: Colors.white,
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage("https://picsum.photos/id/237/200/300"),
                              maxRadius: 15,
                              minRadius: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
