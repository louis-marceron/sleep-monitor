import 'package:flutter/material.dart';

import '../models/sleep_model.dart';
import '../services/database_service.dart';

class AppModel extends ChangeNotifier {
  Future<List<Sleep>> get sleepList async {
    final db = SleepDatabase();
    return db.getAllSleeps();
  }

  Future<void> delete(Sleep sleep) async {
    (await sleepList).remove(sleep);
    notifyListeners();
  }

  Future<DateTime?> getLastSleepStart() async {
    final sleepList = await this.sleepList;
    return sleepList.isNotEmpty ? sleepList.last.start : null;
  }

  Future<bool> isSleeping() async {
    final sleepList = await this.sleepList;
    return sleepList.isNotEmpty && sleepList.last.isSleeping();
  }

  Future<void> startSleeping() async {
    if (await isSleeping()) {
      throw Exception('Cannot add a new sleep while already sleeping');
    }

    final sleepList = await this.sleepList;
    sleepList.add(Sleep(DateTime.now()));
    notifyListeners();
  }

  Future<void> stopSleeping() async {
    if (!await isSleeping()) {
      throw Exception('Cannot stop sleeping if you\'re not sleeping dummy');
    }

    final sleepList = await this.sleepList;
    sleepList.last.stopSleeping();
    notifyListeners();
  }
}
