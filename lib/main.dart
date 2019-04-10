import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bloc/widgets/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_bloc/repositories/waether_repository.dart';
import 'package:flutter_weather_bloc/repositories/weather_api_client.dart';

class WeatherBlocDelegate extends BlocDelegate{

  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
  }
  
  

}

void main() {
    final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
        httpClient: http.Client(),
      )
    );

    print("Main Activity ");
    BlocSupervisor().delegate = WeatherBlocDelegate();
    runApp(MyApp(weatherRepo: weatherRepository));
  }


class MyApp extends StatefulWidget {

    final WeatherRepository weatherRepo;
    MyApp({this.weatherRepo});

    @override
    State<StatefulWidget> createState() => _AppState();
    
}

class _AppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
            title: "Weather Flutter",
            theme: ThemeData(
              primaryColor: Colors.lightBlue
            ),
            color: Colors.lightBlue,
            home: Weather(weatherRepository: widget.weatherRepo),
          );
  }     
  
}
