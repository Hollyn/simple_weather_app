import 'package:flutter/material.dart';
import 'package:simple_weather_app/screens/city_screen.dart';
import 'package:simple_weather_app/services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationData;
  const LocationScreen({Key? key, required this.locationData})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    updateUI(widget.locationData);
  }

  late String cityName;
  late double temperature;
  late int condition;
  late String weatherIcon;
  late String weatherMessage;
  late String cityNameReturned;

  void cityData(String city) async {
    var cityWeatherData = await weatherModel.getCityWeather(city);
    updateUI(cityWeatherData);
  }

  void updateUI(locationData) {
    setState(() {
      cityName = locationData['name'];
      temperature = locationData['main']['temp'];
      condition = locationData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      updateUI(await weatherModel.getLocationWeather());
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      cityNameReturned = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (cityNameReturned != '') {
                        cityData(cityNameReturned);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toStringAsFixed(0)}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
