import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/network_info.dart';
import '../../../core/resources/app_strings.dart';

abstract class AppConfigDataSource {
  Future<String> getWeatherApiKey();
  Future<String?> getWeatherApiKeyFromLocal();
}

@LazySingleton(as: AppConfigDataSource)
class AppConfigDataSourceImpl implements AppConfigDataSource {
  FirebaseFirestore firestore;
  SharedPreferences sharedPreferences;
  NetworkInfo networkInfo;
  AppConfigDataSourceImpl(
      this.firestore, this.sharedPreferences, this.networkInfo);
  @override
  Future<String> getWeatherApiKey() async {
    if (await networkInfo.isConnected) {
      final result = await firestore.collection(AppStrings.keyCollection).get();
      final data = result.docs[0].data();
      final newsApiKey = data[AppStrings.apiKeyPrefs];
      saveWeatherApiKeyLocally(newsApiKey);
      return newsApiKey;
    } else {
      throw Exception("No Internet Connection");
    }
  }

  @override
  Future<String?> getWeatherApiKeyFromLocal() async {
    return sharedPreferences.getString(AppStrings.apiKeyPrefs);
  }

  Future<void> saveWeatherApiKeyLocally(String key) async {
    await sharedPreferences.setString(AppStrings.apiKeyPrefs, key);
  }
}