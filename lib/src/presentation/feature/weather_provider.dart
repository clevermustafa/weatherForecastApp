import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weatherapp/src/core/utils/common_function.dart';
import 'package:weatherapp/src/core/utils/toast_utils.dart';
import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';
import 'package:weatherapp/src/data/model/weather_model/list.dart';
import 'package:weatherapp/src/domain/usecase/get_weather_forecast_usecase.dart';

import '../../data/model/weather_model/weather_model.dart';

@lazySingleton
class WeatherProvider extends ChangeNotifier {
  WeatherStatus weatherStatus = WeatherStatus.initial;
  WeatherModel? weatherModel;
  List<List<ForecastList>>? eachDayForecastList;
  String? errorMessage;
  GetWeatherForecastUsecase getWeatherForecastByCityUsecase;
  WeatherProvider(this.getWeatherForecastByCityUsecase);

  Future<void> getWeatheForecast({String? cityName, LatLng? position}) async {
    weatherStatus = WeatherStatus.loading;
    notifyListeners();
    try {
      LatLng coordinate;
      if (position != null) {
        coordinate = LatLng(lat: position.lat, lng: position.lng);
      } else {
        coordinate = await getCoordinateFromAddress(cityName!);
      }
      final data = await getWeatherForecastByCityUsecase.call(coordinate);
      weatherModel = data;
      log("weatherModel!.list!.length ${weatherModel!.list!.length}");
      eachDayForecastList = forecastListOf5Days(weatherModel!.list!);
      weatherStatus = WeatherStatus.loaded;
      notifyListeners();
    } catch (e) {
      ToastUtils.showToast(e.toString(), ToastType.ERROR);
      weatherStatus = WeatherStatus.error;
      notifyListeners();
    }
  }
}

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}
