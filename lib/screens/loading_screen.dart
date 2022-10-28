import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';
import 'location_screen.dart';

const apiKey = 'ac9be9f7b1f18e9bac31d54a275a03f8';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var loc = Location();
  double? lat, long;

  void pushToLocationScreen(dynamic weatherData) {

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }


  Future<void> getLocation() async{
    await loc.getCurrentLocation();

    lat = loc.lat;
    long = loc.long;

   // print(lat);
   // print(long);

    getData();
  }

  /*void getData() async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/'
        'data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

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

      stderr.writeln('cidade: $cityName, temperatura: $temperature, condição: $weatherCondition');

      stderr.writeln(data);  // imprima o resultado
    } else {
      stderr.writeln(response.statusCode);  // senão, imprima o código de erro

    }

    pushToLocationScreen(weatherData);
  }*/

  void getData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    pushToLocationScreen(weatherData);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  /*@override
  void initState() {
    super.initState();
    getLocation();
  }*/

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFoldingCube(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
