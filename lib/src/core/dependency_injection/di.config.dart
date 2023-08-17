// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:weatherapp/src/core/dependency_injection/di.dart' as _i16;
import 'package:weatherapp/src/core/network/network_info.dart' as _i6;
import 'package:weatherapp/src/core/network/network_utils.dart' as _i7;
import 'package:weatherapp/src/core/utils/data_connection_checker.dart' as _i3;
import 'package:weatherapp/src/data/data_source/app_config_data_source/app_config_data_source.dart'
    as _i10;
import 'package:weatherapp/src/data/data_source/weather_data_source/weather_remote_data_source.dart'
    as _i9;
import 'package:weatherapp/src/data/repo_impl/weather_repository_impl.dart'
    as _i13;
import 'package:weatherapp/src/domain/repository/weather_repository.dart'
    as _i12;
import 'package:weatherapp/src/domain/usecase/get_weather_forecast_usecase.dart'
    as _i14;
import 'package:weatherapp/src/presentation/feature/initialize_app_provider.dart'
    as _i11;
import 'package:weatherapp/src/presentation/feature/weather_provider.dart'
    as _i15;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.DataConnectionChecker>(
        () => registerModule.dataConnectionChecker);
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i5.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.lazySingleton<_i6.NetworkInfo>(
        () => _i6.NetworkInfoImpl(gh<_i3.DataConnectionChecker>()));
    gh.lazySingleton<_i7.NetworkUtil>(
        () => _i7.NetworkUtil(dio: gh<_i4.Dio>()));
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i9.WeatherRemoteDataSource>(
        () => _i9.WeatherRemoteDataSourceImpl(gh<_i7.NetworkUtil>()));
    gh.lazySingleton<_i10.AppConfigDataSource>(
        () => _i10.AppConfigDataSourceImpl(
              gh<_i5.FirebaseFirestore>(),
              gh<_i8.SharedPreferences>(),
              gh<_i6.NetworkInfo>(),
            ));
    gh.lazySingleton<_i11.InitializeAppProvider>(
        () => _i11.InitializeAppProvider(gh<_i10.AppConfigDataSource>()));
    gh.lazySingleton<_i12.WeatherRepository>(() => _i13.WeatherRepositoryImpl(
          gh<_i6.NetworkInfo>(),
          gh<_i9.WeatherRemoteDataSource>(),
          gh<_i10.AppConfigDataSource>(),
        ));
    gh.lazySingleton<_i14.GetWeatherForecastUsecase>(
        () => _i14.GetWeatherForecastUsecaseImpl(gh<_i12.WeatherRepository>()));
    gh.lazySingleton<_i15.WeatherProvider>(
        () => _i15.WeatherProvider(gh<_i14.GetWeatherForecastUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i16.RegisterModule {}
