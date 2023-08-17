import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/src/core/dependency_injection/di.dart';
import 'package:weatherapp/src/presentation/feature/initialize_app_provider.dart';
import 'package:weatherapp/src/presentation/pages/initialization_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt.get<InitializeAppProvider>()..getWeatherApiKey(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
        home: const InitializationPage(),
      ),
    );
  }
}
