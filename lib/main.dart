import 'package:flutter/material.dart';
import 'configs/router_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      routerConfig: rootRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
