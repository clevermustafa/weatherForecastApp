import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/src/core/dependency_injection/di.dart';
import 'package:weatherapp/src/presentation/feature/initialize_app_provider.dart';
import 'package:weatherapp/src/presentation/feature/weather_provider.dart';
import 'package:weatherapp/src/presentation/pages/weather_page/weather_page.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({super.key});

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  final status = context.watch<InitializeAppProvider>().status;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<InitializeAppProvider>(context).status;
    if (status == InitializeAppStatus.loaded) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => getIt.get<WeatherProvider>(),
              child: const WeatherPage(),
            ),
          ),
        );
      });
    }
    return Scaffold(
        body: Stack(
      children: [
        status == InitializeAppStatus.error
            ? Center(
                child: Text(
                    Provider.of<InitializeAppProvider>(context).errorMessage ??
                        "Error"),
              )
            : const SizedBox(),
        status == InitializeAppStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox()
      ],
    ));
  }
}
