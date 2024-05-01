

abstract class Sleep {
  Future<Sleep> create(DateTime start, DateTime? end);

  static Future<List<Sleep>> getAllSleeps();

  Future<DateTime?> getEnd();
  Future<DateTime> getStart();
  Future<void> setEnd(DateTime dateTime);
  Future<void> setStart(DateTime dateTime);
}

