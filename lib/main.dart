// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // ignore: prefer_typing_uninitialized_variables
  var temp;
  // ignore: prefer_typing_uninitialized_variables
  var description;
  // ignore: prefer_typing_uninitialized_variables
  var currently;
  // ignore: prefer_typing_uninitialized_variables
  var humidity;
  // ignore: prefer_typing_uninitialized_variables
  var windspeed;
  // ignore: prefer_typing_uninitialized_variables
  var city;
  var sunrise;
  var sunset;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=-7.89145945&lon=110.33614768316843&units=metric&appid=e42b9722d62b644a3b13549d36292666'));
    var results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windspeed = results['wind']['speed'];
      city = results['name'];
      sunrise = results['sys']['sunrise'];
      sunset = results['sys']['sunset'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      "Currently" + city != null ? city.toString() : "Loading",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.8,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u0000" : "Loading",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    // ignore: deprecated_member_use
                    leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: const Text('Temperature'),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0C" : "Loading"),
                  ),
                  ListTile(
                    // ignore: deprecated_member_use
                    leading: const FaIcon(FontAwesomeIcons.cloud),
                    title: const Text('Weather'),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading"),
                  ),
                  ListTile(
                    // ignore: deprecated_member_use
                    leading: const FaIcon(FontAwesomeIcons.sun),
                    title: const Text('Humidity'),
                    trailing: Text(humidity != null
                        ? humidity.toString() + "%"
                        : "Loading"),
                  ),
                  ListTile(
                    // ignore: deprecated_member_use
                    leading: const FaIcon(FontAwesomeIcons.wind),
                    title: const Text('Wind Speed'),
                    trailing: Text(windspeed != null
                        ? windspeed.toString() + " m/s"
                        : "Loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
