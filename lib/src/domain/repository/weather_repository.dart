

import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';

import '../../data/model/weather_model/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherForecast(LatLng position);
}