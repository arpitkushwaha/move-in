import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:move_in/controller/ApiClass.dart';
import 'package:move_in/views/selectedCityScreen.dart';

class CompareCitiesScreen extends StatefulWidget {
  final Map<String, String> cityStateMap;

  const CompareCitiesScreen({Key key, this.cityStateMap}) : super(key: key);
  @override
  _CompareCitiesScreenState createState() => _CompareCitiesScreenState();
}

class _CompareCitiesScreenState extends State<CompareCitiesScreen> {
  Map<String, double> weatherData = new Map<String, double>();
  //Map<String, String> cityStateMap = new Map<String, String>();
  Map<String, LatLng> latLon = new Map<String, LatLng>();
  List<String> cities;
  List<String> states;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cities = widget.cityStateMap.keys.toList();
    states = widget.cityStateMap.values.toList();
    cities.forEach((element) {
      _getWeatherOfCity(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    // cityStateMap = ModalRoute.of(context).settings.arguments as Map<String,String>;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: cities.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, right: 20, left: 20),
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, Constants.selectedCityScreenRoute);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedCityScreen(
                                    state: states[index],
                                    city: cities[index],
                                    lat: latLon[cities[index]]
                                        .latitude,
                                    lon: latLon[cities[index]]
                                        .longitude,
                                  )));
                    },
                    child: Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.greenAccent[100],
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                '${cities[index]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              SizedBox(
                                height: 10,
                              ),

                              weatherData[cities[index]] !=
                                      null
                                  ?
                              Text(
                                      //'Weather: ${nextInt(22, 29)}C',
                                      'Weather: ${(weatherData[cities[index]] - 273.15).toInt()}C',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green[900],
                                      ), //Textstyle
                                    )
                                  : Text(
                                      "Loading...",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green[900],
                                      ),
                                    ),
                              //SizedBox
                              //   Text(
                              //     'Weather: ${nextInt(22, 29)}C',
                              //     //'Weather: ${(weatherData[widget.cityStateMap.keys.toList()[index]] - 273.15).toInt()}C',
                              //     style: TextStyle(
                              //     fontSize: 15,
                              //     color: Colors.green[900],
                              //   ), //Textstyle
                              // ), //Text/SizedBox
                              //SizedBox
                            ],
                          ), //Column
                        ), //Padding
                      ), //SizedBox
                    ),
                  ),
                ) //Card
                    ;
              }),
        ),
      ),
    );
  }

  String _getWeatherOfCity(String s) {
    Map<String, dynamic> apiData = {
      "url":
          "https://api.openweathermap.org/data/2.5/weather?q=$s&appid=c794b3973a356c05d76b172dda6f433b",
    };
    ApiClass.getApiCall(apiData, (onSuccess) async {
      print(onSuccess);

      if (onSuccess != null && onSuccess["response"] != null) {
        var jsonRoot = jsonDecode(onSuccess["response"]);
        //weatherData[s] = nextInt(24,30).toString();
        var coord = jsonRoot["coord"];
        var m = jsonRoot["main"];
        print("TEMP: ${m['temp']}");
        print("${m["temp"]} => COORD: ${coord["lat"]}, ${coord["lon"]}");
        setState(() {
          weatherData[s] = m['temp'];
          latLon[s] = LatLng(coord["lat"], coord["lon"]);
        });
      } else {
        setState(() {
          weatherData[s] = nextInt(23, 30).toDouble();
          latLon[s] = LatLng(75.8167, 26.9167);
        });
      }
    }, (onError) {
      print("onErrorPage -> $onError");
      setState(() {
        weatherData[s] = nextInt(23, 30).toDouble();
        latLon[s] = LatLng(75.8167, 26.9167);
      });
    });
  }

  int nextInt(int min, int max) => min + Random().nextInt((max + 1) - min);
}
