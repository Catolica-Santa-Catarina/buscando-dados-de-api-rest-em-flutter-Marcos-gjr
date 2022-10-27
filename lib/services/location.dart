import 'dart:convert';
import 'package:geolocator/geolocator.dart';


class Location{

  late double lat;
  late double long;

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error('A permissão para acesso a localização foi negada para sempre. Não é possível pedir permissão.');
    }
  }

  Future<void> getCurrentLocation() async {
    await checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    lat = position.latitude;
    long = position.longitude;

    //print(position);

  }

}