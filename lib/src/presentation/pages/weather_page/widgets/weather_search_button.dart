import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/toast_utils.dart';
import '../../../feature/weather_provider.dart';

class WeatherSearchDialog extends StatelessWidget {
  const WeatherSearchDialog({
    super.key,
    required this.weatherProvider,
    required this.searchWeatherByCityController,
  });
  final WeatherProvider weatherProvider;
  final TextEditingController searchWeatherByCityController;

  search(BuildContext context) {
    if (searchWeatherByCityController.text.isEmpty) {
      ToastUtils.showToast("City name field is empty", ToastType.ERROR);
    } else if (searchWeatherByCityController.text.length < 4) {
      ToastUtils.showToast(
          "City name must not be less than 4 characters", ToastType.ERROR);
    } else {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
      weatherProvider.getWeatheForecast(
          cityName: searchWeatherByCityController.text);

      searchWeatherByCityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AppBar(),
          TextField(
            textInputAction: TextInputAction.search,
            controller: searchWeatherByCityController,
            decoration: InputDecoration(
              hintText: "Search forecast detail by city name",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  search(context);
                },
                icon: const Icon(CupertinoIcons.search),
              ),
            ),
            
            onSubmitted: (val) {
              search(context);
            },
          ),
        ],
      ),
    );
  }
}
