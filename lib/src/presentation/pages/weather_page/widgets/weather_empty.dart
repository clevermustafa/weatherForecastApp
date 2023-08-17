import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/src/presentation/feature/weather_provider.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/widgets/weather_search_dialog.dart';

class WeatherEmpty extends StatelessWidget {
  WeatherEmpty({
    super.key,
  });

  final TextEditingController searchWeatherByCityController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text("No Weather Record"),
        ),
        ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context1) {
                  return Dialog.fullscreen(
                    child: WeatherSearchDialog(
                      searchWeatherByCityController:
                          searchWeatherByCityController,
                      weatherProvider:
                          Provider.of<WeatherProvider>(context, listen: false),
                    ),
                  );
                },
              );
            },
            child: const Text("Search"))
      ],
    );
  }
}
