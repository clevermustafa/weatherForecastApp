import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_source/app_config_data_source/app_config_data_source.dart';


@lazySingleton
class InitializeAppProvider extends ChangeNotifier {
  InitializeAppStatus status = InitializeAppStatus.loading;
  String? errorMessage;
  final AppConfigDataSource appConfigDataSource;
  InitializeAppProvider(this.appConfigDataSource);

  Future<void> getWeatherApiKey() async {
    try {
      String? apiKeyFromLocal =
          await appConfigDataSource.getWeatherApiKeyFromLocal();
      if (apiKeyFromLocal == null) {
        /// this method gets api key from firestore and saves it locally in shared preference.
        await appConfigDataSource.getWeatherApiKey();
        status = InitializeAppStatus.loaded;
        notifyListeners();
      } else {
        status = InitializeAppStatus.loaded;
        notifyListeners();
      }
    } catch (e) {
      status = InitializeAppStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}

enum InitializeAppStatus {
  loading,
  loaded,
  error,
}
