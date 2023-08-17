import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/src/core/utils/common_function.dart';
import 'package:weatherapp/src/core/utils/extensions.dart';
import 'package:weatherapp/src/data/model/weather_model/lat_lng.dart';
import 'package:weatherapp/src/data/model/weather_model/list.dart';
import 'package:weatherapp/src/presentation/feature/weather_provider.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/widgets/weather_detail_widget.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/widgets/weather_empty.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/widgets/weather_loading.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/widgets/weather_search_dialog.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController searchWeatherByCityController =
      TextEditingController();

  @override
  initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    final location = await getCurrentLocation();
    if (location != null) {
      final latlng = LatLng(lat: location.latitude, lng: location.longitude);
      // ignore: use_build_context_synchronously
      Provider.of<WeatherProvider>(context, listen: false)
          .getWeatheForecast(position: latlng)
          .then((value) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
        ),
        child: SafeArea(
          top: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Provider.of<WeatherProvider>(context).weatherModel ==
                            null
                        ? WeatherEmpty()
                        : CustomScrollView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            slivers: [
                              SliverAppBar(
                                backgroundColor: Colors.blue.shade200,
                                pinned: true,
                                expandedHeight: 100,
                                flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: false,
                                  titlePadding: const EdgeInsets.only(left: 8),
                                  collapseMode: CollapseMode.pin,
                                  title: Text(
                                    Provider.of<WeatherProvider>(context)
                                            .weatherModel
                                            ?.city
                                            ?.name ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context1) {
                                          return Dialog.fullscreen(
                                              child: WeatherSearchDialog(
                                            searchWeatherByCityController:
                                                searchWeatherByCityController,
                                            weatherProvider:
                                                Provider.of<WeatherProvider>(
                                                    context,
                                                    listen: false),
                                          ),);
                                        },
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(CupertinoIcons.search),
                                  )
                                ],
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Provider.of<WeatherProvider>(context)
                                                .weatherModel
                                                ?.list?[0]
                                                .main
                                                ?.temp
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "°C",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                          Text(
                                            Provider.of<WeatherProvider>(
                                                        context)
                                                    .weatherModel
                                                    ?.list?[0]
                                                    .weather?[0]
                                                    .description
                                                    ?.capitalizeFirst() ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${getDayFromDateTime(
                                          DateTime.parse(
                                              Provider.of<WeatherProvider>(
                                                          context)
                                                      .weatherModel
                                                      ?.list?[0]
                                                      .dtTxt ??
                                                  ''),
                                        )},',
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('Humidity: '),
                                      Text(
                                        Provider.of<WeatherProvider>(context)
                                                .weatherModel
                                                ?.list?[0]
                                                .main
                                                ?.humidity
                                                .toString() ??
                                            '',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              for (List<ForecastList> fl
                                  in Provider.of<WeatherProvider>(context)
                                      .eachDayForecastList!)
                                SliverToBoxAdapter(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: WeatherDetailWidget(forecastList: fl),
                                )),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
              Provider.of<WeatherProvider>(context).weatherStatus ==
                      WeatherStatus.loading
                  ? const WeatherLoading()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
