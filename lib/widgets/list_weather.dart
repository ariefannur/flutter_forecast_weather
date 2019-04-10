import 'package:flutter/material.dart';
import 'package:flutter_weather_bloc/models/model.dart';
import 'package:intl/intl.dart';

class ListWeather extends StatefulWidget{
  final ResultWeather resultWeather;
  ListWeather({this.resultWeather});

  @override
  State<StatefulWidget> createState() => _ListWeather();

}

class _ListWeather extends State<ListWeather>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 24.0,top:  16.0, right: 24.0, bottom: 16.0),
      itemCount: widget.resultWeather.forecast.forecastDay.length,
      itemBuilder: (BuildContext context, int index){
        final ForecastDay forecastDay = widget.resultWeather.forecast.forecastDay[index];
        var date = new DateTime.fromMillisecondsSinceEpoch(forecastDay.dateEpoch * 1000);
        var formatter = new DateFormat('EEE');
        String formatted = formatter.format(date);

        return Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(formatted, style: TextStyle(fontSize: 16.0), textAlign: TextAlign.left,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          Flexible(child: Text(forecastDay.day.avgTempC.toString()+"∘C", style: TextStyle(fontSize: 21.0), textAlign: TextAlign.left), flex: 1),
                          Flexible(child: Image.network(forecastDay.day.condition.icon, width: 30.0, height: 30.0,), flex: 1)
                      ],
                    )
                    
                    ],
                  ),
                
                
                
            
        );
      },
    );
  }
  
}