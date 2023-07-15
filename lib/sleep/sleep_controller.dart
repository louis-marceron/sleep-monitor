import 'package:flutter/material.dart';

class SleepModel extends ChangeNotifier {
  final List<Sleep> _sleepList = <Sleep>[];

  List<Sleep> get sleepList => _sleepList;

  bool isSleeping() {
    return _sleepList.isNotEmpty && sleepList.last.isSleeping();
  }

  void startSleeping() {
    if (isSleeping()) {
      throw Exception('Cannot add a new sleep while already sleeping');
    }
    _sleepList.add(Sleep(DateTime.now()));
    notifyListeners();
  }

  void stopSleeping() {
    if (!isSleeping()) {
      throw Exception('Cannot stop sleeping if you\'re not sleeping dummy');
    }
    _sleepList.last.stopSleeping();
    notifyListeners();
  }

  DateTime? getLastSleepStart() {
    return _sleepList.isNotEmpty ? _sleepList.last.start : null;
  }
}

class Sleep {
  final DateTime start;
  DateTime? end;

  Sleep(this.start);
  Sleep.finished(this.start, this.end);

  bool isSleeping() => end == null;

  void stopSleeping() {
    if (!isSleeping()) {
      throw Exception('Cannot stop sleeping if you\'re not sleeping dummy');
    }
    end = DateTime.now();
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
