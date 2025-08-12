import 'package:flutter/material.dart';
import 'configs/router_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configs/theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: MaterialTheme(Typography.blackCupertino).dark(),
      theme: MaterialTheme(Typography.whiteCupertino).light(),
      routerConfig: rootRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
