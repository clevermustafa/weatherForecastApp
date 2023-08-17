import 'package:flutter/material.dart';
import 'package:weatherapp/src/core/utils/common_function.dart';
import 'package:weatherapp/src/data/model/weather_model/list.dart';

class WeatherDetailWidget extends StatelessWidget {
  final List<ForecastList> forecastList;
  const WeatherDetailWidget({
    required this.forecastList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              getDayDateAndMonFomString(forecastList[0].dtTxt!),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            itemCount: forecastList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                elevation: 6,
                child: Container(
                  height: 130,
                  width: 70,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade300,
                          Colors.blue.shade50,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        parseHoursAMPM(stringToDateTime(forecastList[index].dtTxt!)),
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Image.network(forecastList[index].weather![0].getIconUrl(), height: 40,width: 40,),
                      Text(
                        "${forecastList[index].main!.temp}°C",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}
