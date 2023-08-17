
import 'package:weatherapp/src/core/utils/common_function.dart';

import 'city.dart';
import 'list.dart';

class WeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List<ForecastList>? list;
  City? city;

  WeatherModel({this.cod, this.message, this.cnt, this.list, this.city});

  @override
  String toString() {
    return 'WeatherModel(cod: $cod, message: $message, cnt: $cnt, list: $list, city: $city)';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cod: json['cod'] as String?,
        message: json['message'] as int?,
        cnt: json['cnt'] as int?,
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => ForecastList.fromJson(e))
            .toList(),
        city: json['city'] == null
            ? null
            : City.fromJson(json['city'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': list?.map((e) => e.toJson()).toList(),
        'city': city?.toJson(),
      };
}
/// takes list of forecast data and gives forecast data according to dates in the give forecast list.
List<List<ForecastList>> forecastListOf5Days(List<ForecastList> forecastList) {
  List<List<ForecastList>> separatedForecastList = [];
  DateTime comparisonDate = stringToDateTime(forecastList[0].dtTxt!);
  List<ForecastList> tempForecast = [];
  for (int i = 0; i < forecastList.length; i++) {
    if (stringToDateTime(forecastList[i].dtTxt!).isSameDate(comparisonDate)) {
      tempForecast.add(forecastList[i]);
    } else {
      separatedForecastList.add(tempForecast);
      tempForecast = [];
      comparisonDate = stringToDateTime(forecastList[i].dtTxt!);
      tempForecast.add(forecastList[i]);
    }
  }
  if(separatedForecastList.length < 5) {
    separatedForecastList.add(tempForecast);
  }
  
  return separatedForecastList;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
