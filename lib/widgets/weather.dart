import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/blocs/wather_bloc.dart';
import 'package:flutter_weather_bloc/repositories/waether_repository.dart';
import 'package:flutter_weather_bloc/widgets/header_weather.dart';
import 'package:flutter_weather_bloc/widgets/list_weather.dart';

class Weather extends StatefulWidget{

  final WeatherRepository weatherRepository;
  Weather({this.weatherRepository});

  @override
  State<StatefulWidget> createState() => _WeatherState();

}

class _WeatherState extends State<Weather>{
  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _weatherBloc.dispatch(FetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (_, WeatherState state){
            if(state != null){
              print("weather ");
              if (state is WeatherEmpty) {
                print("loading : weather ");
              }
              if (state is WeatherEmpty) {
                return Center(child: Text('Please Select a Location'));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if(state is WeatherLoaded){
                final weather = state.weatherResult;
                print("weather :: "+weather.toString());

                return Container(
                  child: Column(
                    children: <Widget>[
                      HeaderWeather(resultWeather: weather),
                      ListWeather(resultWeather: weather)
                    ],
                  ),
                );
              }
            }

          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }

}