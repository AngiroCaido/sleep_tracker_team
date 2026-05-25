import 'package:flutter_test/flutter_test.dart';
import 'package:sleep_tracker_team/models/sleep_record.dart';
import 'package:sleep_tracker_team/repositories/sleep_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SleepRecordAdapter());
  });

  test('Добавление и получение записей', () async {
    final repo = SleepRepository();
    final now = DateTime.now();
    final record = SleepRecord(
      bedtime: now,
      wakeup: now.add(Duration(hours: 8)),
    );
    await repo.addRecord(record);
    final records = await repo.getAllRecords();
    expect(records.length, 1);
    expect(records.first.bedtime, now);
  });
}