import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:async';

import 'package:flutter_weather_bloc/models/model.dart';

class WeatherApiClient {
    static const baseUrl = "https://api.apixu.com/v1/forecast.json/";
    static const KEY = "70c5c9d745c248dd83d41140191803";
    final http.Client httpClient;

    WeatherApiClient({
      @required this.httpClient
    });

    Future<ResultWeather> getForecast(double lat, double lng) async{
      final forecastUrl= '$baseUrl?key=$KEY&q=$lat%2C$lng&days=4';
      final forecastResponse = await this.httpClient.get(forecastUrl);

      print("AF req data "+forecastUrl);
      if(forecastResponse.statusCode != 200){
        throw Exception('error getting weather for location');
      }

     
      final Map<String, dynamic> forecastJson = jsonDecode(forecastResponse.body);
      
      try{
        return ResultWeather.fromJson(forecastJson);   
      }catch(e){
        print("error geet "+e.toString());
        return ResultWeather();
      }    
    }
}