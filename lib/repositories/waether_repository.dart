
import 'package:flutter_weather_bloc/models/model.dart';
import 'package:flutter_weather_bloc/repositories/weather_api_client.dart';
import 'package:meta/meta.dart';

class WeatherRepository{
    final WeatherApiClient weatherApiClient;

    WeatherRepository({
      @required this.weatherApiClient
    });

    Future<ResultWeather> getForcast(double lat, double lng) async {
        // double lat = -7.7608217;
        // double lng = 110.3765883;
        return await weatherApiClient.getForecast(lat, lng);
    }
}