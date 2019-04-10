import 'package:equatable/equatable.dart';
class ResultWeather extends Equatable{
  final Current current;
  final Location location;
  final Forecast forecast;
  ResultWeather({
    this.current,
    this.location,
    this.forecast
  }): super([current, location, forecast]);

  static ResultWeather fromJson(Map<String, dynamic>json){
    final locationName = json['location']['name'] as String;
    final locationRegion = json['location']['region'] as String;

    final currentTempC = json['current']['temp_c'] as double;
    final currentTempF = json['current']['temp_f'] as double;
    var curIcon = json['current']['condition']['icon'] as String;
    curIcon = curIcon.substring(2, curIcon.length);

    final Current current = Current(tempC: currentTempC, tempF: currentTempF, condition: Condition(icon: "http://"+curIcon));
    final Location location = Location(name: locationName, region: locationRegion);
    List<dynamic> listForecast = json['forecast']['forecastday'];

    List<ForecastDay> usedForecast = List();
    for(var i =0; i < listForecast.length; i++){
        double tmpC = listForecast[i]['day']['avgtemp_c'];
        double tmpF = listForecast[i]['day']['avgtemp_c'];
        String icon = listForecast[i]['day']['condition']['icon'];
        icon = icon.substring(2, icon.length);
        Day day = Day(avgTempC: tmpC, avgTempF: tmpF, condition: Condition(icon: "http://"+icon));
        ForecastDay forecastDay = ForecastDay(dateEpoch: listForecast[i]['date_epoch'], day: day);
        usedForecast.add(forecastDay);
    }

    final Forecast forecast = Forecast(
      forecastDay: usedForecast
    );

    final result = ResultWeather(
      location: location,
      current: current,
      forecast: forecast
    );

    return result;
  }
}

class Current extends Equatable{
  final double tempC;
  final double tempF;
  final Condition condition;
  Current({
    this.tempC,
    this.tempF,
    this.condition
  }):super([tempC, tempF]);
}

class Condition extends Equatable{
  final String icon;
  Condition({this.icon});
}

class Location extends Equatable{
  final String region;
  final String name;

  Location({
    this.region,
    this.name
  }) : super([region, name]);

}

class Forecast extends Equatable{
  final List<ForecastDay> forecastDay;
  Forecast({
    this.forecastDay
  }): super([forecastDay]);
}

class ForecastDay extends Equatable{
    final int dateEpoch;
    final Day day;
    ForecastDay({
      this.dateEpoch,
       this.day
    }): super([dateEpoch, day]);
}

class Day extends Equatable{
  final double avgTempC;
  final double avgTempF;
  final Condition condition;
  Day({
    this.avgTempC, this.avgTempF, this.condition
  }): super([avgTempC, avgTempF]);
}