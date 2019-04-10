
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_bloc/models/model.dart';
import 'package:flutter_weather_bloc/repositories/waether_repository.dart';
import 'package:meta/meta.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final ResultWeather weatherResult;

  WeatherLoaded({@required this.weatherResult})
      : super([weatherResult]);
}


class WeatherError extends WeatherState {}


class FetchWeather extends WeatherEvent{}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
    final WeatherRepository weatherRepository;

    WeatherBloc({ @required this.weatherRepository});

  @override
  WeatherState get initialState => WeatherEmpty();


    @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{

    if(event is FetchWeather){
        yield WeatherLoading();
        try{
          
          final ResultWeather resultWeather = await weatherRepository.getForcast();
          print("get data : "+resultWeather.toString());
          yield WeatherLoaded(weatherResult: resultWeather);
        } catch (e){
          print("error : "+e.toString());
          yield WeatherError();
        }
    }else{
      yield WeatherEmpty();
    }

  }

  
}