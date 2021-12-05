import 'dart:convert';
import 'package:covid/model/t_cases.dart';
import 'package:covid/world.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'location/location_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio _dio = Dio();
  Tcases? tcases;
  final String url = "https://corona.lmao.ninja/v2/all";

  Future<Tcases?> getCase() async {
    try {
      Response covidData = await _dio.get(url);
      final convertDataJSON = jsonDecode(covidData.toString());
      tcases = Tcases.fromJson(convertDataJSON);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return tcases;
  }



  @override
  void initState() {
    getCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    navigateToCountry()  {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => World()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID - 19 Tracker'),
        backgroundColor: const Color(0xFF152238),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Stay",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Card(
                      color: Colors.green,
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    'WorldWide Statistics',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Indian Statistics',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            FutureBuilder<Tcases?>(
                future: getCase(),
                builder: (BuildContext context, snap) {
                  if (snap.hasData) {
                    final covid = snap.data;
                    return Column(
                      children: <Widget>[
                        Card(
                            color: const Color(0xFF292929),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "cases\n${covid!.cases}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "deaths\n${covid.deaths}",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "recovered\n${covid.recovered}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    child: Container(
                      color: const Color(0xFF292929),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("images/india.png"),
                              height: 90,
                              width: 90,
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            ElevatedButton(
                                onPressed: () {},
                                child:
                                const Text("India \nState wise Statistics",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xFFfe9900))),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      color: const Color(0xFF292929),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("images/world.png"),
                              height: 90,
                              width: 90,
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            ElevatedButton(
                              onPressed: () {
                                navigateToCountry();
                              },
                              child:
                              const Text(" \nWorld wise Statistics",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFFfe9900))),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Card(
              child: Container(
                color: const Color(0xFF292929),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("images/myth.png"),
                        height: 90,
                        width: 90,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () {},
                        child:
                        const Text("Myth Buster",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFFfe9900))),

                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
