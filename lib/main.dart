import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'sleep/home_view.dart';
import 'sleep/sleep_controller.dart';
import 'settings/settings_view.dart';

void main() {
  runApp(const MyApp());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.primary);

    final SleepModel sleepModel = context.watch<SleepModel>();
    ElevatedButton sleepButton;

    if (sleepModel.isSleeping()) {
      sleepButton = ElevatedButton(
        onPressed: sleepModel.stopSleeping,
        child: Text('Stop sleeping', style: style),
      );
    } else {
      sleepButton = ElevatedButton(
        onPressed: sleepModel.startSleeping,
        child: Text('Start sleeping', style: style),
      );
    }

    return Scaffold(
      bottomNavigationBar: const App(),
      body: Center(
        child: Column(
          children: [
            const SleepList(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: sleepButton,
            ),
          ],
        ),
      ),
    );
  }
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
          const Placeholder(),
          const MyWidget(),
        ][currentPageIndex],
      ),
    );
  }
}

class SleepCard extends StatelessWidget {
  final Sleep sleep;

  const SleepCard({super.key, required this.sleep});

  @override
  Widget build(BuildContext context) {
    final String sleepLength =
        sleep.end?.difference(sleep.start).toString() ?? 'Currently sleeping';

    return Card(
      child: ListTile(
        title: Text(sleepLength),
      ),
    );
  }
}

class SleepList extends StatelessWidget {
  const SleepList({super.key});

  @override
  Widget build(BuildContext context) {
    SleepModel sleepModel = context.watch<SleepModel>();
    List<SleepCard> sleepList =
        sleepModel.sleepList.map((sleep) => SleepCard(sleep: sleep)).toList();

    return Expanded(child: ListView(children: sleepList));
  }
}
