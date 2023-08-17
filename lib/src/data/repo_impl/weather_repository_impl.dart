import 'package:injectable/injectable.dart';
import 'package:weatherapp/src/core/network/network_info.dart';
import 'package:weatherapp/src/data/data_source/app_config_data_source/app_config_data_source.dart';
import 'package:weatherapp/src/data/data_source/weather_data_source/weather_remote_data_source.dart';
import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';
import 'package:weatherapp/src/domain/repository/weather_repository.dart';

import '../model/weather_model/weather_model.dart';
@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  NetworkInfo networkInfo;
  WeatherRemoteDataSource weatherRemoteDataSource;
  AppConfigDataSource appConfigDataSource;
  WeatherRepositoryImpl(
      this.networkInfo, this.weatherRemoteDataSource, this.appConfigDataSource);
  @override
  Future<WeatherModel> getWeatherForecast(LatLng position) async {
    if (await networkInfo.isConnected) {
      try {
        final apiKey = await appConfigDataSource.getWeatherApiKeyFromLocal();
        return await weatherRemoteDataSource.getWeatherForecast(
            position, apiKey!);
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }
}
