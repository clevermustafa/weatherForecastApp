import 'package:injectable/injectable.dart';
import 'package:weatherapp/src/core/network/network_utils.dart';
import 'package:weatherapp/src/core/resources/app_url.dart';
import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';

import '../../model/weather_model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherForecast(LatLng position, String apiKey);
}

@LazySingleton(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  NetworkUtil networkUtil;
  WeatherRemoteDataSourceImpl(this.networkUtil);
  @override
  Future<WeatherModel> getWeatherForecast(
      LatLng position, String apiKey) async {
    try {
      final response = await networkUtil.get(
          "${AppUrl.baseUrl}${AppUrl.forecast}?lat=${position.lat}&lon=${position.lng}&appid=$apiKey&units=metric");
      if (response.statusCode == 200) {
        WeatherModel weatherModel = WeatherModel.fromJson(response.data);
        return weatherModel;
      } else {
        throw Exception("Server Exception");
      }
    } catch (e) {
      rethrow;
    }
  }
}
