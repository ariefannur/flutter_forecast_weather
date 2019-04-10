import 'package:flutter/material.dart';
import 'package:flutter_weather_bloc/models/model.dart';

class HeaderWeather extends StatefulWidget{
  final ResultWeather resultWeather;
  HeaderWeather({this.resultWeather});

  @override
  State<StatefulWidget> createState() => _HeaderWeather();
  
}

class _HeaderWeather extends State<HeaderWeather>{
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(left: 24.0, right:24.0, top: 16.0, bottom: 16.0),
              child: Column(
              children: <Widget>[
               
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Text(widget.resultWeather.current.tempC.toString()+"∘", style: TextStyle(fontSize: 50.0),),
                        Image.network(widget.resultWeather.current.condition.icon)
                      ],
                    ),
  
                Text(widget.resultWeather.location.region, style: TextStyle(fontSize: 24.0), textAlign: TextAlign.left,)
          
      ],
    ),
    );
    
  }

}