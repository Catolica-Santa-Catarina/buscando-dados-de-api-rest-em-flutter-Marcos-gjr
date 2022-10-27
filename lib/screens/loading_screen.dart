import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';

const apiKey = 'ac9be9f7b1f18e9bac31d54a275a03f8';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var loc = Location();
  double? lat, long;

  Future<void> getLocation() async{



    await loc.getCurrentLocation();

    lat = loc.lat;
    long = loc.long;

   // print(lat);
   // print(long);
    getData();
  }

  void getData() async {

    lat = loc.lat;
    long = loc.long;
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) { // se a requisição foi feita com sucesso
      var data = response.body;
      var jsonData = jsonDecode(data);

      var cityName = jsonData['name'];
      var temperature = jsonData['main']['temp'];
      var weatherCondition = jsonData['weather'][0]['id'];

      print('cidade: $cityName, temperatura: $temperature, condição: $weatherCondition');

      print(data);  // imprima o resultado
    } else {
      print(response.statusCode);  // senão, imprima o código de erro

    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(

    );
  }
}
