import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_model.dart';
import '../models/sleep_model.dart';

class SleepList extends StatelessWidget {
  const SleepList({super.key});

  @override
  Widget build(BuildContext context) {
    AppModel sleepModel = context.watch<AppModel>();
    List<SleepCard> sleepList = sleepModel.sleepList
        .where((sleep) => !sleep.isSleeping())
        .map((sleep) => SleepCard(sleep: sleep))
        .toList();

    return ListView(children: sleepList);
  }
}

class SleepCard extends StatelessWidget {
  final Sleep sleep;

  const SleepCard({super.key, required this.sleep});

  @override
  Widget build(BuildContext context) {
    AppModel sleepModel = context.watch<AppModel>();
    final Duration sleepDuration = sleep.end!.difference(sleep.start);

    return Card(
      child: ListTile(
        title: Text(
          Sleep.formatDuration(sleepDuration),
        ),
        trailing: IconButton(
          onPressed: () => sleepModel.delete(sleep),
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
