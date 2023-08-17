import 'package:injectable/injectable.dart';
import 'package:weatherapp/src/core/use_cases/use_cases.dart';
import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';
import 'package:weatherapp/src/data/model/weather_model/weather_model.dart';
import 'package:weatherapp/src/domain/repository/weather_repository.dart';

abstract class GetWeatherForecastUsecase extends UseCases<WeatherModel, LatLng> {}
@LazySingleton(as: GetWeatherForecastUsecase)
class GetWeatherForecastUsecaseImpl implements GetWeatherForecastUsecase {
  WeatherRepository weatherRepository;
  GetWeatherForecastUsecaseImpl(this.weatherRepository);
  @override
  Future<WeatherModel> call(LatLng params) async {
    return await weatherRepository.getWeatherForecast(params);
  }
}