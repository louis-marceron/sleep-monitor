import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'sleep_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Center(child: SleepTimer()),
          ),
          SleepButton(),
        ],
      ),
    );
  }
}

class SleepButton extends StatelessWidget {
  const SleepButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SleepModel sleepModel = context.watch<SleepModel>();
    FilledButton sleepButton;

    if (sleepModel.isSleeping()) {
      sleepButton = FilledButton(
        onPressed: () => sleepModel.stopSleeping(),
        child: const Text('Stop sleeping'),
      );
    } else {
      sleepButton = FilledButton(
        onPressed: () => sleepModel.startSleeping(),
        child: const Text('Start sleeping'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: sleepButton,
    );
  }
}

class SleepTimer extends StatefulWidget {
  const SleepTimer({super.key, required});

  @override
  State<SleepTimer> createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  Duration? _sleepLength;

  void _setTimer() {
    // If I don't use listen: false, it crashes because only widgets can listen to providers.
    final SleepModel sleepModel =
        Provider.of<SleepModel>(context, listen: false);
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(() {
        if (sleepModel.isSleeping()) {
          setState(() {
            _sleepLength =
                DateTime.now().difference(sleepModel.getLastSleepStart()!);
          });
        } else {
          _sleepLength = null;
        }
      }),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    _setTimer();
  }

  // FIXME I don't know if I should use dispose().

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayLarge!;

    if (_sleepLength != null) {
      return Text(_formatDuration(_sleepLength!), style: style);
    } else {
      return Text('00:00:00', style: style);
    }
  }
}
