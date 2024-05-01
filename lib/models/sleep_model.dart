class Sleep {
  final DateTime start;
  DateTime? end;

  Sleep(this.start, [this.end]);

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

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }

  @override
  String toString() {
    return 'Sleep{start: $start, end: $end}';
  }
}
