import 'package:flutter/material.dart';

import 'initialize_app.dart';
import 'presentation/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestNotificationPermission();
  await intilializeSharedPref();

  runApp(initializeRepoReturnMyAPP());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reward Coins App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "SpaceGrotesk",
      ),
      home: const HomeScreen(),
    );
  }
}
