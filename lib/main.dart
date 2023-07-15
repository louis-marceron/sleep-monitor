import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings/settings_view.dart';
import 'sleep/home_view.dart';
import 'sleep/sleep_controller.dart';
import 'insights/insights_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SleepModel(),
      child: MaterialApp(
        title: 'Sleep monitor',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff6750A4),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: [
          const Home(),
          const SleepList(),
          const MyWidget(),
        ][currentPageIndex],
      ),
    );
  }
}
