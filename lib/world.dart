import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  final String url = "https://corona.lmao.ninja/v3/covid-19/countries";
  late Future<List> datas;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data;
  }

  @override
  void initState() {
    datas = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('country wise stats'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: datas,
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.hasData) {

              return GridView.builder(
                  itemCount: datas.toString().length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, index) => SizedBox(
                        height: 50,
                        width: 50,
                        child: GestureDetector(
                          onTap: () => showcard(
                              snap.data[index]['cases'].toString(),
                              snap.data[index]['todayDeaths'].toString(),
                              snap.data[index]['deaths'].toString(),
                              snap.data[index]['recovered'].toString()),
                          child: Card(
                            color: Color(0xFF292929),
                            child: Container(
                              color: Color(0xFF292929),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Image(
                                      image: AssetImage("images/world.png"),
                                      height: 85,
                                      width: 85,
                                    ),
                                    Text(
                                      snap.data[index]['country'].toString(),
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future showcard(String cases, tdeath, death, recover) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: const RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    "Total Cases : ${cases}",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Today Deaths : ${death}",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Total Deaths : ${tdeath}",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Total recovers : ${recover}",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
